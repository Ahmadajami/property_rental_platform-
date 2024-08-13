
import 'package:airbnb/models/user_model/model.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pocketbase/pocketbase.dart';

abstract class AuthRepository {
  Future<UserModel> login(String email, String password);
  Future<void> signup(Map <String, dynamic> formData,XFile avatar);
  Future<void> logout();
  Stream<AuthStoreEvent> get authStoreChange;

}