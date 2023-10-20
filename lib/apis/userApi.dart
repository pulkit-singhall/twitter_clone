import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/constants/appwrite_constants.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/models/user_model.dart';

// user api provider
final userApiProvider = Provider((ref) {
  final appWriteDatabase = ref.watch(appWriteDatabaseProvider);
  return UserAPI(database: appWriteDatabase);
});

abstract class IUserAPI {
  // storing user data in the database
  FutureEither<void> storeUserData({required UserModel user});
}

class UserAPI implements IUserAPI {
  Databases database;
  UserAPI({required this.database});

  @override
  FutureEither<void> storeUserData({required UserModel user}) async {
    try {
      await database.createDocument(
          databaseId: AppWriteConstants.projectDatabaseId,
          collectionId: AppWriteConstants.userCollectionId,
          documentId: ID.unique(),
          data: user.toMap());
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(message: e.message.toString(), stackTrace: st));
    } catch (e, st) {
      return left(Failure(message: e.toString(), stackTrace: st));
    }
  }
}
