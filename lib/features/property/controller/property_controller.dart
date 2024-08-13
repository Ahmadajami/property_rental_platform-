import 'dart:async';
import 'dart:developer';
import 'package:airbnb/features/property/controller/paging/paging.dart';
import 'package:airbnb/features/property/controller/query.dart';
import 'package:airbnb/features/property/repository/property_repository.dart';
import 'package:airbnb/models/property_model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';


final paginatedListProvider = FutureProvider.autoDispose.family<List<PropertyModel>,PagingCriteria >((ref,criteria )
async {

    final repo=ref.read(propertyRepositoryProvider);
    final query =ref.watch(searchQueryProvider);
    if( query == null || query.isEmpty)
      {
        return repo.paginationList(criteria: criteria);
      }
    else{
      return repo.paginationList(criteria: criteria,query: query);
    }
});
//---------------
final latestProvider = FutureProvider.autoDispose<List<PropertyModel>>((ref) async {
  return ref.read(propertyRepositoryProvider).latest();
});
//---------------
final getPropertyByIdProvider = FutureProvider.autoDispose.family<PropertyModel, String>((ref,id ) async {
  return  ref.read(propertyRepositoryProvider).getById(id: id);
});
//------------------
final  userPropertyProvider = FutureProvider.autoDispose<List<PropertyModel>>
(
(ref) async {
  final repo=ref.read(propertyRepositoryProvider);
return repo.userProperty();
});

final asyncPropertyProvider =
AsyncNotifierProvider.autoDispose<PropertyController, List<PropertyModel>> (()=> PropertyController());
class PropertyController extends AutoDisposeAsyncNotifier <List<PropertyModel>> {
  PropertyRepository get _repo => ref.read(propertyRepositoryProvider);
  @override
  FutureOr<List<PropertyModel>> build() async {
   return await _repo.getAll();
  }
  Future<void> bookProperty(PropertyModel model,DateTime start,DateTime end,VoidCallback onDone) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repo.bookProperty(model, start, end);
      return _repo.getAll();
    });
    if(!state.hasError){
      ref.invalidate(latestProvider);
       onDone();
    }


  }

  Future<void> addProperty(PropertyModel model,List<XFile> image,VoidCallback onDone) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repo.addProperty(model, image);
      ref.refresh(userPropertyProvider);
      return _repo.getAll();
    });
    if(!state.hasError){
      ref.invalidate(latestProvider);
      onDone();

    }
    else{
      log("in propertey controller erorr:  state.error.toString() \n");
      log(state.error.toString());
    }


  }

}