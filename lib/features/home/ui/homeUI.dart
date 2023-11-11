import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/home/widgets/bottomItem.dart';
import 'package:twitter_clone/features/home/widgets/feed_page.dart';
import 'package:twitter_clone/features/home/widgets/notification_page.dart';
import 'package:twitter_clone/features/home/widgets/search_page.dart';
import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/theme/theme.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int currentPage = 0;
  List<Widget> homeWidgets = const [
    FeedPage(),
    SearchPage(),
    NotificationPage()
  ];

  @override
  Widget build(BuildContext context) {
    final UserModel currentUserModel =
        ref.watch(currentUserModelProvider).value!;
    final String profilePic = currentUserModel.profilePic;
    final String name = currentUserModel.name;
    final int followers = currentUserModel.followers.length;
    final int following = currentUserModel.following.length;

    return Scaffold(
      appBar: UICommon.reusableAppBar(),
      body: IndexedStack(
        index: currentPage,
        children: homeWidgets,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // tweet screen navigation
          Navigator.push(context, Routes.newTweetRoute());
        },
        backgroundColor: Pallete.blueColor,
        elevation: 3,
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
          size: 35,
        ),
      ),
      drawer: Drawer(
        backgroundColor: Pallete.backgroundColor,
        elevation: 3,
        child: SafeArea(
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(profilePic),
                radius: 25,
              ),
              Text(
                name,
                style: const TextStyle(color: Pallete.whiteColor, fontSize: 20),
              ),
              Text(
                '@$name',
                style: const TextStyle(color: Pallete.greyColor, fontSize: 18),
              ),
              Row(
                children: [

                ],
              ),
            ],
          ),
        ),
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
