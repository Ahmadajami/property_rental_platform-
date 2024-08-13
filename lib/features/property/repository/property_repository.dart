
import 'package:airbnb/core/constants/pocketbase_constants.dart';
import 'package:airbnb/core/providers/pocketbase.dart';
import 'package:airbnb/features/auth/controller/auth_controller.dart';
import 'package:airbnb/features/property/controller/paging/paging.dart';
import 'package:airbnb/models/booking_model/model.dart';
import 'package:airbnb/models/property_model/model.dart';
import 'package:airbnb/models/user_model/model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;

final propertyRepositoryProvider = Provider<PropertyRepository>((ref) {
  final pb = ref.watch(pocketBaseProvider);
  final userModel = ref.watch(authControllerProvider.notifier).userModel!;
  return PropertyRepository(pb: pb, userModel: userModel);
});


class PropertyRepository {
  final PocketBase _pb;
  final UserModel _userModel;

  PropertyRepository({required PocketBase pb, required UserModel userModel})
      : _pb = pb,
        _userModel = userModel;

  Future<List<PropertyModel>> _fetchData(
      {  PagingCriteria paging = const PagingCriteria()}) async {
    try {


      final ResultList<RecordModel> results = await _pb
          .collection(PocketBaseConstants.propertyCollection)
          .getList(
              expand: paging.expand ,
              filter: paging.filter,
              page: paging.page,
              perPage: paging.perPage,
              sort: paging.sort);


      return results.items.map((property) {
        return PropertyModel.fromRecord(property);
      }).toList();
    } catch (error) {

      rethrow;
    }
  }

  Future<List<PropertyModel>> getAll({int page = 1, int perPage = 30}) async {
    return await _fetchData(paging: PagingCriteria(page: page,perPage: perPage));
  }

  Future<List<PropertyModel>> latest({int perPage = 5, int page = 1}) async {
    return await _fetchData(paging: PagingCriteria(sort:"-created",perPage: perPage
    ,page: page,filter: "availability_status=true && owner != '${_userModel.id.toString()}' "));

  }

  Future<PropertyModel> getById({required String id}) async {
    try {
      final record = await _pb
          .collection(PocketBaseConstants.propertyCollection)
          .getOne(id, expand: "owner");
      return  PropertyModel.fromJson(record.toJson());
    } catch (error) {
      rethrow;
    }
  }
  Future<void> bookProperty(PropertyModel model,DateTime start,DateTime end) async {
    try{
     await _pb.collection(PocketBaseConstants.propertyCollection).update(
         model.id,
         body: model.copyWith(availabilityStatus: false).toJson());
      final dateDifferenceInDays=end.difference(start).inDays;

     await _pb.collection(PocketBaseConstants.bookingCollection).create(
       body:BookingModel(propertyId: model.id, tenantId: _userModel.id, checkInDate:start,
           checkOutDate: end, totalPrice:model.priceDaily * dateDifferenceInDays, bookingStatus: BookingStatus.pending ).toJson(),
     );
    }
    catch(e){
      rethrow;
    }
  }
  Future<List<PropertyModel>> paginationList({ required PagingCriteria criteria,String? query}) async {
      PagingCriteria cr =criteria.copyWith(sort:"-created",filter:"availability_status=true && owner != '${_userModel.id.toString()}' ",expand: null);
      try{
        if(query== null || query.isEmpty)
          {

            return await _fetchData(paging: cr);
          }

        final filter="(address ~ '$query' || description ~ '$query' ) && availability_status=true  && owner != '${_userModel.id.toString()}'";
        cr=cr.copyWith(filter: filter);

        return await _fetchData(paging: cr);
      }
      catch(e){
        rethrow;
      }






  }

  Future<List<PropertyModel>> userProperty() async{
    try{

      final criteria= PagingCriteria(filter: 'owner="${_userModel.id.toString()}"',);
      return await _fetchData(paging: PagingCriteria(expand: "",sort:"-created", filter:criteria.filter ));
    }
    catch(error){
      rethrow;
    }
  }

  Future<String?> addProperty(PropertyModel model ,List<XFile> file) async{
    try{
      final m=model.copyWith(images: [],owner: _userModel.id);
      final prop=await _pb.collection(PocketBaseConstants.propertyCollection).create(
          body: m.toJson(),
          files:[
            for(final image in file )
              http.MultipartFile.fromBytes("images", await image.readAsBytes(),
                   filename: "names"),
          ] );

      final id=prop.getDataValue<String>('id');
      return id;

    }catch(error){

      rethrow;
    }
  }


}


