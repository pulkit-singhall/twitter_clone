import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../apis/authApi.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  final authApi = ref.watch(authApiProvider);
  return AuthController(authApi: authApi);
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI authApi;

  AuthController({required this.authApi}) : super(false);

  // signup
  void signUp({required String email, required String password}) async {
    state = true;
    final userModel = await authApi.signUp(email: email, password: password);
    userModel.fold((l){
      print('Error in SignUp ${l.message}');
    }, (r){
      state = false;
      print('Signup Success');
    });
  }

  // login

}
