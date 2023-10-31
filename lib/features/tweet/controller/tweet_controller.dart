import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TweetController extends StateNotifier<bool>{
  TweetController() : super(false);

  // tweet share action
  void shareTweet({required String text, required BuildContext context}){

  }

  // getting hashtags from the tweet
  List<String> _getHashTagFromTweet (String tweet){
    List<String> hashTags = [];
    List<String> words = tweet.split(' ');

    for(String word in words){
      if(word.startsWith('#')){
        hashTags.add(word);
      }
    }
    return hashTags;
  }

  // getting links from the tweet
  List<String> _getLinkFromTweet (String tweet){
    List<String> words = tweet.split(' ');
    List<String> links = [];
    for(String word in words){
      if(word.startsWith('https://') || word.startsWith('www.')){
        links.add(word);
      }
    }
    return links;
  }
}