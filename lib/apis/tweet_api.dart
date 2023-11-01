import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/constants/appwrite_constants.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/models/tweet_model.dart';

// global tweet api provider
final tweetApiProvider = Provider((ref) {
  final appwriteDatabase = ref.watch(appWriteDatabaseProvider);
  return TweetApi(databases: appwriteDatabase);
});

abstract class ITweetApi {

  // share/store tweet
  FutureEither<void> shareTweet({required TweetModel tweetModel});
}

class TweetApi implements ITweetApi {
  final Databases databases;
  TweetApi({required this.databases});

  @override
  FutureEither<void> shareTweet({required TweetModel tweetModel}) async {
    try {
      await databases.createDocument(
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
}
