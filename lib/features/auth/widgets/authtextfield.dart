import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/theme.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscure;

  const AuthTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.isObscure});

  final focusedBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(6)),
    borderSide: BorderSide(
      color: Pallete.blueColor,
      width: 2
    )
  );

  final enabledBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(6)),
      borderSide: BorderSide(
          color: Pallete.greyColor,
          width: 2
      )
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 390,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: focusedBorder,
          enabledBorder: enabledBorder,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
        obscureText: isObscure,
        maxLines: 1,
      ),
    );
  }
}
