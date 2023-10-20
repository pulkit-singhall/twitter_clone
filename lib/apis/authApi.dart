import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:appwrite/models.dart' as model;

// auth api provider
final authApiProvider = Provider((ref) {
  final appWriteAccount = ref.watch(appWriteAccountProvider);
  return AuthAPI(account: appWriteAccount);
});

// we have created an abstract class so that all the functions remain there
// for our backend in a single class.
// if we need to change our backend to a different platform then we can just
// write from scratch the new code in different class implemented from this
// abstract class.

abstract class IAuthAPI {
  // here we will just write the snippet of functions used in auth
  // signup
  FutureEither<model.User> signUp(
      {required String email, required String password});

  // login
  FutureEither<model.Session> login(
      {required String email, required String password});

  // get user instance
  Future<model.User?> getUserInstance();


}

class AuthAPI implements IAuthAPI {
  final Account account;

  AuthAPI({required this.account});

  @override
  FutureEither<model.User> signUp(
      {required String email, required String password}) async {
    try {
      final userModel = await account.create(
          userId: ID.unique(), email: email, password: password);
      return right(userModel);
    } on AppwriteException catch (e, stackTrace) {
      return left(
          Failure(message: e.message.toString(), stackTrace: stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }

  @override
  FutureEither<model.Session> login({required String email, required String password}) async {
    try{
      final userSession = await account.createEmailSession(email: email, password: password);
      return right(userSession);
    }
    on AppwriteException catch(e, stackTrace){
      return left(Failure(message: e.message.toString(), stackTrace: stackTrace));
    }
    catch(e, stackTrace){
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }

  @override
  Future<model.User?> getUserInstance() async {
    try{
      final userInstance = await account.get();
      return userInstance;
    }
    on AppwriteException catch(e){
      return null;
    }
    catch(e){
      return null;
    }
  }
}
