import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/models/tweet_model.dart';

// global tweet controller provider
final tweetControllerProvider = StateNotifierProvider<TweetController, bool>((ref) {
  return TweetController(ref: ref);
});

class TweetController extends StateNotifier<bool> {
  final Ref ref;
  TweetController({required this.ref}) : super(false);

  // tweet share action
  void shareTweet({required String tweetText, required BuildContext context}) {
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
}
