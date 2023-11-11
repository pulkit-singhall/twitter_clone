import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/theme.dart';

class TweetText extends StatelessWidget {
  final String text;

  const TweetText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    List<TextSpan> tweetText = [];
    List<String> oldTweetText = text.split(' ');

    for (String text in oldTweetText) {
      if (text.startsWith('#')) {
        tweetText.add(TextSpan(
          text: '$text ',
          style: const TextStyle(
            color: Pallete.blueColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ));
      }
      else if (text.startsWith('www.') || text.startsWith('https://')) {
        tweetText.add(TextSpan(
          text: '$text ',
          style: const TextStyle(
            color: Pallete.blueColor,
            fontSize: 20,
          ),
        ));
      }
      else{
        tweetText.add(TextSpan(
          text: '$text ',
          style: const TextStyle(
            color: Pallete.whiteColor,
            fontSize: 20,
          ),
        ));
      }
    }

    return RichText(
        text: TextSpan(
      children: tweetText,
    ));
  }
}
