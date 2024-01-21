import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/models/user_model.dart';
import '../../../theme/theme.dart';

class OtherUserProfile extends ConsumerStatefulWidget {
  final UserModel user;
  const OtherUserProfile({super.key, required this.user});

  @override
  ConsumerState<OtherUserProfile> createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends ConsumerState<OtherUserProfile> {
  @override
  Widget build(BuildContext context) {

    final currentUserModel = ref.watch(currentUserModelProvider).value;
    final currentUserId = currentUserModel?.uid;
    final otherUserId = widget.user.uid;

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
                        backgroundImage: NetworkImage(widget.user.profilePic),
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
                        child: Text(
                          currentUserId == otherUserId ? 'Edit Profile' : 'Follow',
                          style: const TextStyle(
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
                    widget.user.name,
                    style: const TextStyle(
                        color: Pallete.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 32),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '@${widget.user.name}',
                    style:
                        const TextStyle(color: Pallete.greyColor, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.user.bio,
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
                        widget.user.following.length.toString(),
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
                        style:
                            TextStyle(color: Pallete.greyColor, fontSize: 22),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        widget.user.followers.length.toString(),
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
                        style:
                            TextStyle(color: Pallete.greyColor, fontSize: 22),
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
  }
}