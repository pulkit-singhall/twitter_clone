import 'package:flutter/material.dart';
import 'package:twitter_clone/features/auth/ui/loginUI.dart';
import 'package:twitter_clone/features/auth/ui/signUpUI.dart';
import 'package:twitter_clone/features/home/ui/homeUI.dart';

class Routes {
  // signup
  static MaterialPageRoute signUpRoute() {
    return MaterialPageRoute(builder: (context) {
      return const SignUpUI();
    });
  }

  // login
  static MaterialPageRoute loginRoute(){
    return MaterialPageRoute(builder: (context){
      return const LoginUI();
    });
  }

  static MaterialPageRoute homeRoute(){
    return MaterialPageRoute(builder: (context){
      return const HomeScreen();
    });
  }

}
