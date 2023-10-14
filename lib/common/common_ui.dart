import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../theme/theme.dart';
import '../constants/constants.dart';

class UICommon {

  static Center progressIndicator() {
    return const Center(
      child: RefreshProgressIndicator(
        color: Pallete.blueColor,
        backgroundColor: Pallete.backgroundColor,
        strokeWidth: 3,
      ),
    );
  }

  static AppBar reusableAppBar() {
    return AppBar(
      centerTitle: true,
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        height: 35,
        width: 35,
        color: Pallete.blueColor,
      ),
    );
  }

}
