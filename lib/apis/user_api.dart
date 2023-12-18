import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/constants/appwrite_constants.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:appwrite/models.dart' as model;
import 'package:twitter_clone/models/user_model.dart';

// user api provider
final userApiProvider = Provider((ref) {
  final appWriteDatabase = ref.watch(appWriteDatabaseProvider);
  return UserAPI(database: appWriteDatabase);
});

abstract class IUserAPI {
  // storing user data in the database
  FutureEither<void> storeUserData(
      {required UserModel user, required String documentId});

  // retrieving user data
  Future<model.Document> retrieveUserData({required String uid});

  // retrieving all the users documents from the database
  Future<List<model.Document>> getAllUsers();

  // get all users by searching a particular name
  Future<List<model.Document>> getUsersByName(String name);
}

class UserAPI implements IUserAPI {
  Databases database;
  UserAPI({required this.database});

  @override
  FutureEither<void> storeUserData(
      {required UserModel user, required String documentId}) async {
    try {
      await database.createDocument(
          databaseId: AppWriteConstants.projectDatabaseId,
          collectionId: AppWriteConstants.userCollectionId,
          documentId: documentId,
          data: user.toMap());
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(message: e.message.toString(), stackTrace: st));
    } catch (e, st) {
      return left(Failure(message: e.toString(), stackTrace: st));
    }
  }

  @override
  Future<model.Document> retrieveUserData({required String uid}) async {
    final userDocument = await database.getDocument(
        databaseId: AppWriteConstants.projectDatabaseId,
        collectionId: AppWriteConstants.userCollectionId,
        documentId: uid);
    return userDocument;
  }

  @override
  Future<List<model.Document>> getAllUsers() async {
    final userDocumentsList = await database.listDocuments(
        databaseId: AppWriteConstants.projectDatabaseId,
        collectionId: AppWriteConstants.userCollectionId);
    return userDocumentsList.documents;
  }

  @override
  Future<List<model.Document>> getUsersByName(String name) async {
    final userByName = await database.listDocuments(
        databaseId: AppWriteConstants.projectDatabaseId,
        collectionId: AppWriteConstants.userCollectionId,
    queries: [
      Query.search('name', name),
    ]);
    return userByName.documents;
  }
}
