import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/assets_constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/features/tweet/widgets/publicView.dart';
import 'package:twitter_clone/theme/theme.dart';

class NewTweet extends ConsumerStatefulWidget {
  const NewTweet({super.key});

  @override
  ConsumerState<NewTweet> createState() => _TweetState();
}

class _TweetState extends ConsumerState<NewTweet> {
  TextEditingController tweetTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentUserModel = ref.watch(currentUserModelProvider).value;
    final tweetController = ref.watch(tweetControllerProvider.notifier);
    final isLoading = ref.watch(tweetControllerProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Pallete.whiteColor,
              size: 30,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: ElevatedButton(
                onPressed: () {
                  // tweet
                  if (tweetTextController.text.toString().isNotEmpty) {
                    tweetController.shareTweet(
                        tweetText: tweetTextController.text.toString(),
                        context: context);
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      tweetTextController.text.toString().isNotEmpty
                          ? MaterialStateProperty.all<Color>(Pallete.blueColor)
                          : MaterialStateProperty.all<Color>(
                              Pallete.lightBlueColor),
                  elevation: MaterialStateProperty.all<double>(2),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
                ),
                child: const Text(
                  'Tweet',
                  style: TextStyle(
                      color: Pallete.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        body: currentUserModel == null || isLoading
            ? UICommon.progressIndicator()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(currentUserModel.profilePic),
                          radius: 25,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        const PublicView(),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 66,
                        ),
                        Expanded(
                          child: TextField(
                            controller: tweetTextController,
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'What\'s Happening?',
                              hintStyle: TextStyle(
                                color: Pallete.greyColor,
                                fontSize: 22,
                              ),
                            ),
                            style: const TextStyle(
                              color: Pallete.whiteColor,
                              fontSize: 22,
                            ),
                            minLines: 1,
                            maxLines: null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        bottomNavigationBar: Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            SvgPicture.asset(
              AssetsConstants.galleryIcon,
              height: 30,
              width: 30,
            ),
            const SizedBox(
              width: 15,
            ),
            SvgPicture.asset(
              AssetsConstants.gifIcon,
              height: 30,
              width: 30,
            ),
            const SizedBox(
              width: 15,
            ),
            SvgPicture.asset(
              AssetsConstants.emojiIcon,
              height: 30,
              width: 30,
            ),
          ],
        ),
      ),
    );
  }
}
