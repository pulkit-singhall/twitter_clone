import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/constants/assets_constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/home/widgets/bottomItem.dart';
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

    final currentUserModel = ref.watch(userModelProvider(userId)).value!;
    final String profilePic = currentUserModel.profilePic;
    final String name = currentUserModel.name;

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
                '@$name',
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomItem(
                  height: 22,
                  width: 22,
                  color: Pallete.greyColor,
                  path: AssetsConstants.commentIcon),
              BottomItem(
                  height: 22,
                  width: 22,
                  color: Pallete.greyColor,
                  path: AssetsConstants.retweetIcon),
              BottomItem(
                  height: 22,
                  width: 22,
                  color: Pallete.greyColor,
                  path: AssetsConstants.likeOutlinedIcon),
              BottomItem(
                  height: 22,
                  width: 22,
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
}
