import 'package:flutter/material.dart';
import 'package:twitter_clone/common/common_ui.dart';
import 'package:twitter_clone/features/auth/widgets/authtextfield.dart';
import 'package:twitter_clone/theme/pallete.dart';

class LoginUi extends StatefulWidget {
  const LoginUi({super.key});

  @override
  State<LoginUi> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final appBar = UICommon.reusableAppBar();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AuthTextField(
                controller: email, hintText: 'Email Address', isObscure: false),
            const SizedBox(
              height: 25,
            ),
            AuthTextField(
                controller: password, hintText: 'Password', isObscure: true),
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () {
                // navigate and signup
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Pallete.whiteColor),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                )),
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(80, 40)),
                elevation: MaterialStateProperty.all(0),
              ),
              child: const Text(
                'Done',
                style: TextStyle(
                  color: Pallete.backgroundColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 390,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Pallete.blueColor,
                          fontSize: 16,
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
