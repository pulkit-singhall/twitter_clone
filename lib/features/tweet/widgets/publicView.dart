import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/theme.dart';

class PublicView extends StatelessWidget {
  const PublicView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: const Border(
          top: BorderSide(
            color: Pallete.blueColor,
            width: 2,
          ),
          bottom: BorderSide(
            color: Pallete.blueColor,
            width: 2,
          ),
          right: BorderSide(
            color: Pallete.blueColor,
            width: 2,
          ),
          left: BorderSide(
            color: Pallete.blueColor,
            width: 2,
          ),
        )
      ),
      child: const Text(
        'Public',
        style: TextStyle(
            color: Pallete.blueColor,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
