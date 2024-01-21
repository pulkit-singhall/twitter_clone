import 'package:flutter/material.dart';
import 'package:twitter_clone/features/auth/ui/loginUI.dart';
import 'package:twitter_clone/features/auth/ui/signUpUI.dart';
import 'package:twitter_clone/features/home/ui/homeUI.dart';
import 'package:twitter_clone/features/profile/ui/otherUser_profile.dart';
import 'package:twitter_clone/features/profile/ui/user_profile.dart';
import 'package:twitter_clone/features/tweet/ui/newTweet.dart';
import 'package:twitter_clone/models/user_model.dart';

class Routes {
  // signup
  static MaterialPageRoute signUpRoute() {
    return MaterialPageRoute(builder: (context) {
      return const SignUpUI();
    });
  }

  // login
  static MaterialPageRoute loginRoute() {
    return MaterialPageRoute(builder: (context) {
      return const LoginUI();
    });
  }

  static MaterialPageRoute homeRoute() {
    return MaterialPageRoute(builder: (context) {
      return const HomeScreen();
    });
  }

  static MaterialPageRoute newTweetRoute() {
    return MaterialPageRoute(builder: (context) {
      return const NewTweet();
    });
  }

  static MaterialPageRoute profilePageRoute() {
    return MaterialPageRoute(builder: (context) {
      return const UserProfile();
    });
  }

  static MaterialPageRoute otherProfilePageRoute(UserModel user){
    return MaterialPageRoute(builder: (context){
      return OtherUserProfile(user: user);
    });
  }
}
