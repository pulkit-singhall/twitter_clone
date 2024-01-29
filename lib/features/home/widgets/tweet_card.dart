import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/assets_constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/home/controller/home_controller.dart';
import 'package:twitter_clone/features/home/widgets/bottomItem.dart';
import 'package:twitter_clone/features/home/widgets/tweet_actions.dart';
import 'package:twitter_clone/features/home/widgets/tweet_text.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/theme/theme.dart';

class TweetCard extends ConsumerStatefulWidget {
  final TweetModel tweet;

  const TweetCard({super.key, required this.tweet});

  @override
  ConsumerState<TweetCard> createState() => _TweetCardState();
}

class _TweetCardState extends ConsumerState<TweetCard> {
  @override
  Widget build(BuildContext context) {
    final String text = widget.tweet.text;
    final String userId = widget.tweet.userId;
    final int likeNumber = widget.tweet.likes.length;
    final int commentNumber = widget.tweet.comments.length;
    final int reshareNumber = widget.tweet.reshareCount;
    final List<String> likes = widget.tweet.likes;

    // user who tweeted this tweet
    final userModel = ref.watch(userModelProvider(userId));
    final homeController = ref.watch(homeControllerProvider.notifier);

    return userModel.when(data: (userModel) {
      final String profilePic = userModel.profilePic;
      final String name = userModel.name;
      final String uid = userModel.uid;

      // current user model
      final currentUserModel = ref.watch(currentUserModelProvider).value;

      if(currentUserModel != null){
        final currentUid = currentUserModel.uid;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(profilePic),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                        color: Pallete.whiteColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '@$name'.toLowerCase(),
                    style: const TextStyle(
                      color: Pallete.greyColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 59,
                  ),
                  Expanded(child: TweetText(text: text)),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TweetActionButton(
                    number: commentNumber.toString(),
                    path: AssetsConstants.commentIcon,
                    onTap: () {},
                  ),
                  TweetActionButton(
                    number: reshareNumber.toString(),
                    path: AssetsConstants.retweetIcon,
                    onTap: () {},
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        homeController.likeTweet(
                            tweet: widget.tweet, currentUser: currentUserModel);
                      });
                    },
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          child: likes.contains(currentUid)
                              ? SvgPicture.asset(
                            AssetsConstants.likeFilledIcon,
                            height: 25,
                            width: 25,
                            color: Pallete.redColor,
                          )
                              : SvgPicture.asset(
                            AssetsConstants.likeOutlinedIcon,
                            height: 25,
                            width: 25,
                            color: Pallete.greyColor,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          likeNumber.toString(),
                          style: TextStyle(
                              fontSize: 18,
                              color: likes.contains(currentUid)
                                  ? Pallete.redColor
                                  : Pallete.greyColor),
                        ),
                      ],
                    ),
                  ),
                  const BottomItem(
                      height: 25,
                      width: 25,
                      color: Pallete.greyColor,
                      path: AssetsConstants.viewsIcon),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Pallete.greyColor,
                height: 0.3,
              )
            ],
          ),
        );
      }
      else{
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
