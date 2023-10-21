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

// user Model provider
final userModelProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  final userModel = authController.retrieveUserData(uid: uid);
  return userModel;
});

// current user Model provider
final currentUserModelProvider = FutureProvider((ref) {
  final userInstance = ref.watch(userInstanceProvider).value!;
  final uid = userInstance.$id;
  final currentUserModel = ref.watch(userModelProvider(uid));
  return currentUserModel.value;
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI authApi;
  final UserAPI userApi;

  AuthController({required this.authApi, required this.userApi}) : super(false);
  // bool = isLoading

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
      final userId = r.$id;
      final userDataStored = await userApi.storeUserData(user: user, documentId: userId);
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

  // get user details
  Future<UserModel> retrieveUserData({required String uid}) async {
    final userDocument = await userApi.retrieveUserData(uid: uid);
    final userModel = UserModel.fromMap(userDocument.data);
    return userModel;
  }
}
