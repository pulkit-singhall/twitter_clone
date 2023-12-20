import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/home/widgets/bottomItem.dart';
import 'package:twitter_clone/features/home/ui/feed_page.dart';
import 'package:twitter_clone/features/home/ui/notification_page.dart';
import 'package:twitter_clone/features/home/ui/search_page.dart';
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
    final currentUserModel =
        ref.watch(currentUserModelProvider);

    final authController =ref.watch(authControllerProvider.notifier);

    Widget homeUI = currentUserModel.when(data: (userModel){
      if(userModel != null){
        final String profilePic = userModel.profilePic;
        final String name = userModel.name;
        final int followers = userModel.followers.length;
        final int following = userModel.following.length;
        return Scaffold(
          appBar: currentPage == 0 ? UICommon.reusableAppBar() : null,
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
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(profilePic),
                        radius: 25,
                      ),
                      onTap: () {
                        // navigate to profile page
                        Navigator.push(context, Routes.profilePageRoute());
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                          color: Pallete.whiteColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      '@$name',
                      style:
                      const TextStyle(color: Pallete.greyColor, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        Text(
                          following.toString(),
                          style: const TextStyle(
                              color: Pallete.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          'Following',
                          style: TextStyle(color: Pallete.greyColor, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          followers.toString(),
                          style: const TextStyle(
                              color: Pallete.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          'Followers',
                          style: TextStyle(color: Pallete.greyColor, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      child: const Text(
                        'Profile',
                        style: TextStyle(
                            color: Pallete.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      onTap: () {
                        Navigator.push(context, Routes.profilePageRoute());
                      },
                    ),
                    const Spacer(),
                    Center(
                        child: ElevatedButton(
                            onPressed: () {
                              // logout action here
                              authController.logout(context);
                            },
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )))
                  ],
                ),
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
      else{
        return UICommon.progressIndicator();
      }
    }, error: (e,st){
      return Center(child: Text(e.toString()),);
    }, loading: (){
      return UICommon.progressIndicator();
    });

    return homeUI;
  }
}
