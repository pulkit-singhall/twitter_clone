import 'package:appwrite/appwrite.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/constants/appwrite_constants.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/models/user_model.dart';
import '../core/typedefs.dart';

abstract class IUserAPI {
  FutureEither<int> storeUserData({required UserModel user});
}

class UserAPI implements IUserAPI {
  Databases database;
  UserAPI({required this.database});

  @override
  FutureEither<int> storeUserData({required UserModel user}) async {
    try {
      await database.createDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.userCollectionId,
          documentId: ID.unique(),
          data: user.toMap());
      return const Right(0);
    } on AppwriteException catch (e, st) {
      return left(Failure(message: e.message.toString(), stackTrace: st));
    } catch (e, st) {
      return left(Failure(message: e.toString(), stackTrace: st));
    }
  }
}
