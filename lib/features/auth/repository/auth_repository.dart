
import 'package:airbnb/core/constants/pocketbase_constants.dart';
import 'package:airbnb/core/providers/pocketbase.dart';

import 'package:airbnb/features/auth/repository/DTO.dart';
import 'package:airbnb/models/user_model/model.dart';

import 'package:http/http.dart' as http;
import 'package:airbnb/features/auth/repository/auth_interface.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocketbase/pocketbase.dart';


final authRepositoryProvider = Provider((ref)  {
   final pb= ref.watch(pocketBaseProvider);
      return PocketBaseAuthImplementation( pb:pb);
}
);

class PocketBaseAuthImplementation implements AuthRepository {
  final PocketBase _pb;


  PocketBaseAuthImplementation({
    required PocketBase pb
  }):_pb=pb;

  @override
  Future<UserModel> login(String email, String password) async {
    try {
     await _pb.collection(PocketBaseConstants.usersCollection)
          .authWithPassword(
        email,
        password,
      );


      return UserMapper.userFromAuthStore(_pb.authStore.model);
    } on ClientException catch (error) {
      throw error.response;
    }
    catch (error){
      rethrow;
    }
  }

  @override
  Future<void>  logout() async {
       _pb.authStore.clear();
  }

  @override
  Stream<AuthStoreEvent> get authStoreChange =>  _pb.authStore.onChange;

  @override
  Future<bool> signup(Map<String, dynamic> formData,XFile? avatar) async {
    try {

      if(avatar != null){

        final image= await avatar.readAsBytes();
        await _pb.collection(PocketBaseConstants.usersCollection).create(
            body: formData,
            files:[
              http.MultipartFile.fromBytes(
                  "avatar", image,
                  contentType:MediaType('image', 'jpeg'),
                  filename: avatar.name),
            ] );
        return true;
      }
       await _pb.collection(PocketBaseConstants.usersCollection).create(body: formData);
      return true;
    }on ClientException  catch (error) {
     throw error.toString();
    }
    catch(error){
      rethrow;
    }

  }
}
