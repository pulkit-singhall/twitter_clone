import 'package:flutter/material.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/theme/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UICommon.reusableAppBar(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Pallete.backgroundColor,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: currentPage,
        onTap: (value){
          setState(() {
            currentPage = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: UICommon.bottomItem(
                AssetsConstants.homeFilledIcon, 30, 30, Pallete.whiteColor),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: UICommon.bottomItem(
                  AssetsConstants.searchIcon, 30, 30, Pallete.whiteColor),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: UICommon.bottomItem(AssetsConstants.notificationFilledIcon,
                  30, 30, Pallete.whiteColor),
              label: 'Notification'),
        ],
      ),
    );
  }
}
