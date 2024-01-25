import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/tweet_api.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/models/tweet_model.dart';

// global tweet controller provider
final tweetControllerProvider = StateNotifierProvider<TweetController, bool>((ref) {
  final tweetApi = ref.watch(tweetApiProvider);
  return TweetController(ref: ref, tweetApi: tweetApi);
});

// future provider for tweets list
final tweetListFutureProvider = FutureProvider((ref) {
  final tweetController = ref.watch(tweetControllerProvider.notifier);
  return tweetController.getTweets();
});

// future provider for user only tweets
final userTweetsModelListProvider = FutureProvider.family((ref, String uid) {
  final tweetController = ref.watch(tweetControllerProvider.notifier);
  return tweetController.getUserTweets(uid);
});

class TweetController extends StateNotifier<bool> {
  final Ref ref;
  final TweetApi tweetApi;
  TweetController({required this.ref, required this.tweetApi}) : super(false);

  // getting tweets list
  Future<List<TweetModel>> getTweets() async {
    List<TweetModel> tweets = [];
    final tweetDocumentList = await tweetApi.getTweets();
    for(var tweet in tweetDocumentList){
      tweets.add(TweetModel.fromMap(tweet.data));
    }
    return tweets;
  }

  // tweet share/store action
  void shareTweet({required String tweetText, required BuildContext context}) async {
    List<String> links = _getLinksFromTweet(tweetText);
    List<String> hashTags = _getHashTagsFromTweet(tweetText);
    final userInstance = ref.watch(userInstanceProvider).value!;
    final String userId = userInstance.$id;
    TweetModel tweetModel = TweetModel(
        likes: const [],
        comments: const [],
        hashtags: hashTags,
        links: links,
        userId: userId,
        tweetId: '',
        tweetTime: DateTime.now(),
        text: tweetText,
        reshareCount: 0);
    state = true;
    final res = await tweetApi.shareTweet(tweetModel: tweetModel);
    res.fold((l) {
      print('error in sharing tweet ${l.message}');
    }, (r) {
      state = false;
      print('Tweet Share Success');
      Navigator.pop(context);
    });
  }

  // getting hashtags from the tweet
  List<String> _getHashTagsFromTweet(String tweetText) {
    List<String> hashTags = [];
    List<String> words = tweetText.split(' ');

    for (String word in words) {
      if (word.startsWith('#')) {
        hashTags.add(word);
      }
    }
    return hashTags;
  }

  // getting links from the tweet
  List<String> _getLinksFromTweet(String tweetText) {
    List<String> words = tweetText.split(' ');
    List<String> links = [];
    for (String word in words) {
      if (word.startsWith('https://') || word.startsWith('www.')) {
        links.add(word);
      }
    }
    return links;
  }

  // get user only tweets
  Future<List<TweetModel>> getUserTweets(String uid) async {
      final List<TweetModel> userTweetList = [];
      final userTweets = await tweetApi.getUserTweets(uid);
      for(var tweets in userTweets){
        userTweetList.add(TweetModel.fromMap(tweets.data));
      }
      return userTweetList;
  }
}
