import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomItem extends StatelessWidget {
  final String path;
  final double height;
  final double width;
  final Color color;

  const BottomItem(
      {super.key,
      required this.height,
      required this.width,
      required this.color,
      required this.path});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      color: color,
      height: height,
      width: width,
    );
  }
}
