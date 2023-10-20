import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/routes.dart';
import 'package:appwrite/models.dart' as model;
import 'package:twitter_clone/models/user_model.dart';
import '../../../apis/authApi.dart';
import '../../../apis/userApi.dart';

// global auth controller provider
final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  final authApi = ref.watch(authApiProvider);
  final userApi = ref.watch(userApiProvider);
  return AuthController(authApi: authApi, userApi: userApi);
});

// user instance provider
final userInstanceProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  final userInstance = authController.getUserInstance();
  return userInstance;
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI authApi;
  final UserAPI userApi;

  AuthController({required this.authApi, required this.userApi}) : super(false);

  // signup
  void signUp(
      {required String email,
      required String password,
      required BuildContext context,
      required UserModel user}) async {
    state = true;
    final userModel = await authApi.signUp(email: email, password: password);
    userModel.fold((l) {
      print('Error in SignUp ${l.message}');
    }, (r) async {
      final userDataStored = await userApi.storeUserData(user: user);
      userDataStored.fold((l){
        print('Error in Storing Data ${l.message}');
      }, (r) {
        state = false;
        Navigator.push(context, Routes.loginRoute());
        print('Signup Success');
      });
    });
  }

  // login
  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final userSession = await authApi.login(email: email, password: password);
    userSession.fold((l) {
      print('Error in Login ${l.message.toString()}');
    }, (r) {
      state = false;
      Navigator.push(context, Routes.homeRoute());
      print('Login Success');
    });
  }

  // user instance
  Future<model.User?> getUserInstance() async {
    final userInstance = await authApi.getUserInstance();
    return userInstance;
  }
}
