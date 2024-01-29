import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/user_api.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/models/user_model.dart';

import '../../../apis/tweet_api.dart';

// home controller provider
final homeControllerProvider = StateNotifierProvider<HomeController,bool>((ref) {
  final userApi = ref.watch(userApiProvider);
  final tweetApi = ref.watch(tweetApiProvider);
  return HomeController(userApi: userApi, tweetAPI: tweetApi);
});

// future provider for searching a user by name
final userListBySearchProvider = FutureProvider.family((ref, String name) {
  final homeController = ref.watch(homeControllerProvider.notifier);
  return homeController.getUsersByName(name);
});

// home controller class
class HomeController extends StateNotifier<bool>{
  final UserAPI userApi;
  final TweetAPI tweetAPI;
  HomeController({required this.userApi, required this.tweetAPI}) : super(false);

  // get all the users model from database
  Future<List<UserModel>> getAllUsers() async {
    final userDocumentsList = await userApi.getAllUsers();
    List<UserModel> allUsersList = [];
    for(var userDocument in userDocumentsList){
      allUsersList.add(UserModel.fromMap(userDocument.data));
    }
    return allUsersList;
  }

  // get all users by searching their name
  Future<List<UserModel>> getUsersByName(String name) async {
      final userDocuments = await userApi.getUsersByName(name);
      List<UserModel> usersBySearch = [];
      for(var userDocument in userDocuments){
        usersBySearch.add(UserModel.fromMap(userDocument.data));
      }
      return usersBySearch;
  }

  // like / unlike a tweet action
  Future<void> likeTweet({required TweetModel tweet, required UserModel currentUser}) async {
    final uid = currentUser.uid;

    // liked tweet already -> unlike action
    if(tweet.likes.contains(uid)){
      tweet.likes.remove(uid);
    }
    // not liked tweet -> like action
    else{
      tweet.likes.add(uid);
    }

    tweet = tweet.copyWith(likes: tweet.likes);

    final likeAction = await tweetAPI.likeTweet(tweet: tweet);

    likeAction.fold((l) {
      print('Error occurred in liking/unliking tweet ${l.message}');
    }, (r) {

    });
  }

}