import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
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
        // final bannerPic = userModel.bannerPic;
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
                      CircleAvatar(
                        backgroundImage: NetworkImage(profilePic),
                        radius: 28,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                            color: Pallete.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '@' + name,
                        style: const TextStyle(
                            color: Pallete.greyColor, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        bio,
                        style: const TextStyle(
                            color: Pallete.whiteColor, fontSize: 22),
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
                                fontSize: 20),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Following',
                            style: TextStyle(
                                color: Pallete.greyColor, fontSize: 18),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            followers.length.toString(),
                            style: const TextStyle(
                                color: Pallete.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Followers',
                            style: TextStyle(
                                color: Pallete.greyColor, fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // tweet list here
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
