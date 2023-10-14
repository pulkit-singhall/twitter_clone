import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common_ui.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/ui/signUpUI.dart';
import 'package:twitter_clone/features/home/ui/homeUI.dart';
import 'package:twitter_clone/theme/theme.dart';
import 'package:appwrite/models.dart' as model;

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInstance = ref.watch(userInstanceProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Twitter Clone',
      themeMode: ThemeMode.dark,
      theme: AppTheme.theme,
      home: userInstance.when(data: (user){
        if(user != null){
          return const HomeScreen();
        }
        return const SignUpUI();
      }, error: (error ,st){
        return Center(
          child: Text(error.toString()),
        );
      }, loading: () {
        return UICommon.progressIndicator();
      }),
    );
  }
}
