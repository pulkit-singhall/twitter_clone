import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import '../../../common/common_ui.dart';
import '../../../theme/theme.dart';
import '../widgets/authtextfield.dart';

class LoginUI extends ConsumerStatefulWidget {
  const LoginUI({super.key});

  @override
  ConsumerState<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends ConsumerState<LoginUI> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final appBar = UICommon.reusableAppBar();

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    final authController = ref.watch(authControllerProvider.notifier);

    return Scaffold(
      appBar: appBar,
      body: isLoading
          ? UICommon.progressIndicator()
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AuthTextField(
                      controller: email,
                      hintText: 'Email Address',
                      isObscure: false),
                  const SizedBox(
                    height: 25,
                  ),
                  AuthTextField(
                      controller: password,
                      hintText: 'Password',
                      isObscure: true),
                  const SizedBox(
                    height: 35,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // navigate and login
                      authController.login(
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
                          'Dont have an account?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Sign Up',
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
