import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/shared/theme.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';
import 'package:lms_app_tugbes/widgets/widget_textfield.dart';

class LoginPageStudent extends StatelessWidget {
  LoginPageStudent({super.key});

  final TextEditingController nisController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Align(
                alignment: const Alignment(1, 4),
                child: SvgPicture.asset('assets/pattern.svg')),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome back',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in as a student',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: secondaryColor, fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: 100,
                    height: 1,
                    color: secondaryColor.withOpacity(0.4),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: margin),
                    child: CustomTextfield(
                      controller: nisController,
                      titleTextfield: 'NIS',
                      hintText: 'Enter your NIS',
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: margin),
                    child: CustomTextfield(
                      controller: passwordController,
                      titleTextfield: 'Password',
                      hintText: 'Enter your password',
                      obsecured: true,
                    ),
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    titleButton: 'Sign In',
                    onTap: () {
                      Get.offNamed('/dashboard');
                    },
                  ),
                  const SizedBox(height: 24),
                  RichText(
                    text: TextSpan(
                      text: 'Sign in as a ',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: secondaryColor),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'teacher',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Get.offNamed('/register-student');
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account yet? ",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: secondaryColor),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
