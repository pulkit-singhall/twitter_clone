import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/constants/appwrite_constants.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:appwrite/models.dart' as model;

// global tweet api provider
final tweetApiProvider = Provider((ref) {
  final appwriteDatabase = ref.watch(appWriteDatabaseProvider);
  return TweetAPI(database: appwriteDatabase);
});

abstract class ITweetAPI {
  // share/store tweet
  FutureEither<void> shareTweet({required TweetModel tweetModel});

  // get tweets
  Future<List<model.Document>> getTweets();

  // get user only tweets
  Future<List<model.Document>> getUserTweets({required String uid});
}

class TweetAPI implements ITweetAPI {
  final Databases database;
  TweetAPI({required this.database});

  @override
  FutureEither<void> shareTweet({required TweetModel tweetModel}) async {
    try {
      await database.createDocument(
          databaseId: AppWriteConstants.projectDatabaseId,
          collectionId: AppWriteConstants.tweetCollectionId,
          documentId: ID.unique(),
          data: tweetModel.toMap());
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(message: e.message.toString(), stackTrace: st));
    } catch (e, st) {
      return left(Failure(message: e.toString(), stackTrace: st));
    }
  }

  @override
  Future<List<model.Document>> getTweets() async {
    final tweetDocumentList = await database.listDocuments(
        databaseId: AppWriteConstants.projectDatabaseId,
        collectionId: AppWriteConstants.tweetCollectionId);
    return tweetDocumentList.documents;
  }

  @override
  Future<List<model.Document>> getUserTweets({required String uid}) async {
    final userTweetList = await database.listDocuments(
        databaseId: AppWriteConstants.projectDatabaseId,
        collectionId: AppWriteConstants.tweetCollectionId,
        queries: [
          Query.search('userId', uid),
        ]);
    return userTweetList.documents;
  }
}
