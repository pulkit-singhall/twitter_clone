import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/theme/theme.dart';

class TweetActionButton extends StatefulWidget {
  final String path;
  final String number;
  final VoidCallback onTap;
  const TweetActionButton(
      {super.key,
      required this.number,
      required this.path,
      required this.onTap});

  @override
  State<TweetActionButton> createState() => _TweetActionButtonState();
}

class _TweetActionButtonState extends State<TweetActionButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child: SvgPicture.asset(
            widget.path,
            color: Pallete.greyColor,
            height: 25,
            width: 25,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          widget.number,
          style: const TextStyle(
            color: Pallete.greyColor,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
