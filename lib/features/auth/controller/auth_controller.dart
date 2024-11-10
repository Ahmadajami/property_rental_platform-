import 'dart:async';
import 'package:airbnb/core/constants/snackbar.dart';
import 'package:airbnb/core/providers/pocketbase.dart';
import 'package:airbnb/core/providers/secure_sharedpref/secure_sharedpref.dart';
import 'package:airbnb/features/auth/repository/DTO.dart';
import 'package:airbnb/features/auth/repository/auth_repository.dart';
import 'package:airbnb/models/user_model/model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocketbase/pocketbase.dart';

final authStreamProvider = StreamProvider((ref) {
  final onChange = ref.watch(pocketBaseProvider).authStore.onChange;
  return onChange;
});

final authControllerProvider =
    AsyncNotifierProvider<AsyncAuthController, UserModel?>(() {
  return AsyncAuthController();
});

class AsyncAuthController extends AsyncNotifier<UserModel?> {
  late UserModel? _user;
  @override
  FutureOr<UserModel?>? build() async {

    if (_authstore.model != null) {
      _user = UserMapper.userFromAuthStore(_authstore.model);
      return UserMapper.userFromAuthStore(_authstore.model);
    }
    return null;
  }

  Future<void> logInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).login(email, password);
      _user = UserMapper.userFromAuthStore(_authstore.model);
      ref.invalidate(authStoreProvider);
      return _user;
    }, (err) {
      const snackBar = SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
        content: Text('invalid credentials!'),
      );
      showSnackBar(context, snackBar);
      return true;
    });

  }
  //------------
AsyncAuthStore get _authstore => ref.watch(authStoreProvider);

  Future<void> signup(Map<String,dynamic> formData,BuildContext context,bool mounted,XFile? avatar) async {
    state = const AsyncValue.loading();
    {
      state= await AsyncValue.guard(() async {
        await ref.read(authRepositoryProvider).signup(formData,avatar);
        if(mounted){
          const snackBar = SnackBar(
            backgroundColor: Colors.green,
            duration: Duration(seconds: 5),
            content: Text('Signed up Successfully!'),
          );
          showSnackBar(context, snackBar);
          context.pop();
        }
        return null;
      }, (err) {

        const snackBar = SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          content: Text('Something went Wrong!'),
        );
        showSnackBar(context, snackBar);
        return true;
      });
      _user = null;

    }

  }

  void logout() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).logout();
      return null;
    },);
    _user = null;
  }

  UserModel? get userModel => _user;
}
