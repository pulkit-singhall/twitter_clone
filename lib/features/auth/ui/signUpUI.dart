import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/routes.dart';
import 'package:twitter_clone/common/common_ui.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/ui/loginUI.dart';
import 'package:twitter_clone/features/auth/widgets/authtextfield.dart';
import 'package:twitter_clone/theme/theme.dart';

class SignUpUI extends ConsumerStatefulWidget {
  const SignUpUI({super.key});

  @override
  ConsumerState<SignUpUI> createState() => _SignUpUIState();
}

class _SignUpUIState extends ConsumerState<SignUpUI> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final appBar = UICommon.reusableAppBar();

  @override
  Widget build(BuildContext context) {
    final authController = ref.watch(authControllerProvider.notifier);
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: appBar,
      body: isLoading ? UICommon.progressIndicator() : Center(
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
                authController.signUp(
                    email: email.text.toString(),
                    password: password.text.toString(),
                context: context);
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
                      onPressed: () {
                        Navigator.push(context, Routes.loginRoute());
                      },
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
