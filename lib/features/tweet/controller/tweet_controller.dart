import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/models/tweet_model.dart';

class TweetController extends StateNotifier<bool>{
  TweetController() : super(false);

  // tweet share action
  void shareTweet({required TweetModel tweet, required BuildContext context}){

  }

  // getting hashtags from the tweet
  List<String> _getHashTagFromTweet (String tweetText){
    List<String> hashTags = [];
    List<String> words = tweetText.split(' ');

    for(String word in words){
      if(word.startsWith('#')){
        hashTags.add(word);
      }
    }
    return hashTags;
  }

  // getting links from the tweet
  List<String> _getLinkFromTweet (String tweetText){
    List<String> words = tweetText.split(' ');
    List<String> links = [];
    for(String word in words){
      if(word.startsWith('https://') || word.startsWith('www.')){
        links.add(word);
      }
    }
    return links;
  }
}