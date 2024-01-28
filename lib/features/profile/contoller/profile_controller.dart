import 'dart:ffi';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/tweet_api.dart';
import 'package:twitter_clone/apis/user_api.dart';
import 'package:twitter_clone/models/user_model.dart';

import '../../../models/tweet_model.dart';

// global profile controller provider
final profileControllerProvider =
    StateNotifierProvider<ProfileController, bool>((ref) {
  final tweetApi = ref.watch(tweetApiProvider);
  final userApi = ref.watch(userApiProvider);
  return ProfileController(tweetApi: tweetApi, userApi: userApi);
});

// specific user tweet list future provider
final userTweetsModelListProvider = FutureProvider.family((ref, String uid) {
  final profileController = ref.watch(profileControllerProvider.notifier);
  return profileController.getUserTweets(uid: uid);
});

class ProfileController extends StateNotifier<bool> {
  final TweetAPI tweetApi;
  final UserAPI userApi;
  ProfileController({required this.tweetApi, required this.userApi}) : super(false);

  // get specific user only tweets
  Future<List<TweetModel>> getUserTweets({required String uid}) async {
    final List<TweetModel> userTweetList = [];
    final userTweets = await tweetApi.getUserTweets(uid: uid);
    for (var tweets in userTweets) {
      userTweetList.add(TweetModel.fromMap(tweets.data));
    }
    return userTweetList;
  }

  // following a user action
  Future<void> followUser({
    required UserModel user,
    required UserModel currentUser,
  }) async {
    // already following
    if(currentUser.following.contains(user.uid)){
      currentUser.following.remove(user.uid);
      user.followers.remove(currentUser.uid);
    }
    // yet to follow
    else{
      currentUser.following.add(user.uid);
      user.followers.add(currentUser.uid);
    }

    user = user.copyWith(followers: user.followers);
    currentUser = currentUser.copyWith(following: currentUser.following);

    final follow = await userApi.followUser(user: user);
    follow.fold((l) {
      print('Error from follow user side ${l.message}');
    }, (r) async {
      final following = await userApi.followingUser(currentUser: currentUser);
      following.fold((l) {
        print('Error from following user side ${l.message}');
      }, (r) {
        print('Follow Success');
      });
    });
  }

  String buttonText({required UserModel currentUser, required UserModel user}){
    final currentUserId = currentUser.uid;
    final userId = user.uid;

    if(currentUserId == userId){
      return 'Edit Profile';
    }
    else{
      if(currentUser.following.contains(userId)){
        return 'Following';
      }
      else{
        return 'Follow';
      }
    }
  }
}
