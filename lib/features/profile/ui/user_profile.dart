import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/home/widgets/tweet_card.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/theme/pallete.dart';

class UserProfile extends ConsumerStatefulWidget {
  const UserProfile({super.key});

  @override
  ConsumerState<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends ConsumerState<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final currentUserModel = ref.watch(currentUserModelProvider);

    return currentUserModel.when(data: (userModel) {
      if (userModel != null) {
        final profilePic = userModel.profilePic;
        final name = userModel.name;
        final bio = userModel.bio;
        final followers = userModel.followers;
        final following = userModel.following;
        final uid = userModel.uid;
        // final bannerPic = userModel.bannerPic;

        final userTweetsList =
            ref.watch(userTweetsModelListProvider(uid)).value;

        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(profilePic),
                            radius: 32,
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              // edit user profile
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  const Size(100, 50)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Pallete.backgroundColor),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      side: const BorderSide(
                                          color: Pallete.greyColor, width: 2))),
                            ),
                            child: const Text(
                              'Edit Profile',
                              style: TextStyle(
                                  color: Pallete.whiteColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                            color: Pallete.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 32),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '@$name',
                        style: const TextStyle(
                            color: Pallete.greyColor, fontSize: 24),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        bio,
                        style: const TextStyle(
                            color: Pallete.whiteColor, fontSize: 24),
                        maxLines: 5,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            following.length.toString(),
                            style: const TextStyle(
                                color: Pallete.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          const Text(
                            'Following',
                            style: TextStyle(
                                color: Pallete.greyColor, fontSize: 22),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            followers.length.toString(),
                            style: const TextStyle(
                                color: Pallete.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          const Text(
                            'Followers',
                            style: TextStyle(
                                color: Pallete.greyColor, fontSize: 22),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final tweet = userTweetsList[index];
                        return TweetCard(tweet: tweet);
                      },
                      itemCount: userTweetsList!.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return UICommon.progressIndicator();
      }
    }, error: (e, st) {
      return Center(
        child: Text(e.toString()),
      );
    }, loading: () {
      return UICommon.progressIndicator();
    });
  }
}
