import 'package:flutter/material.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/home/widgets/bottomItem.dart';
import 'package:twitter_clone/theme/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  List<Widget> homeWidgets = const [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UICommon.reusableAppBar(),
      body: IndexedStack(
        index: currentPage,
        children: homeWidgets,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // tweet action
          Navigator.push(context, Routes.newTweetRoute());
        },
        backgroundColor: Pallete.blueColor,
        elevation: 3,
        child: const Icon(Icons.add, color: Pallete.whiteColor, size: 30,),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Pallete.backgroundColor,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: currentPage,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: BottomItem(
                path: currentPage == 0
                    ? AssetsConstants.homeFilledIcon
                    : AssetsConstants.homeOutlinedIcon,
                height: 30,
                width: 30,
                color: Pallete.whiteColor),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: BottomItem(
                  path: currentPage == 1
                      ? AssetsConstants.searchIcon
                      : AssetsConstants.searchIcon,
                  height: 30,
                  width: 30,
                  color: Pallete.whiteColor),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: BottomItem(
                  path: currentPage == 2
                      ? AssetsConstants.notificationFilledIcon
                      : AssetsConstants.notificationOutlinedIcon,
                  height: 30,
                  width: 30,
                  color: Pallete.whiteColor),
              label: 'Notification'),
        ],
      ),
    );
  }
}
