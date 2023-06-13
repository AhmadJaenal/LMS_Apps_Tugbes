import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/animation/fade_animation.dart';
import 'package:lms_app_tugbes/screens/sign_in_page_student.dart';
import 'package:lms_app_tugbes/shared/theme.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';
import 'package:lms_app_tugbes/widgets/widget_textfield.dart';

class SignUpStudent extends StatefulWidget {
  SignUpStudent({super.key});

  @override
  State<SignUpStudent> createState() => _SignUpStudentState();
}

class _SignUpStudentState extends State<SignUpStudent>
    with SingleTickerProviderStateMixin {
  final TextEditingController nisController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            FadeAnimation(
              childWidget: Align(
                  alignment: const Alignment(1, 4),
                  child: SvgPicture.asset('assets/pattern.svg',
                      fit: BoxFit.cover)),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeAnimation(
                      offsetY: -100,
                      childWidget: Column(
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: margin),
                      child: FadeAnimation(
                        childWidget: CustomTextfield(
                          controller: nisController,
                          titleTextfield: 'NIS',
                          hintText: 'Enter your NIS',
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: margin),
                      child: FadeAnimation(
                        childWidget: CustomTextfield(
                          controller: passwordController,
                          titleTextfield: 'Password',
                          hintText: 'Enter your password',
                          obsecured: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: margin),
                      child: FadeAnimation(
                        childWidget: CustomTextfield(
                          controller: passwordController,
                          titleTextfield: 'Validation password',
                          hintText: 'Enter your password',
                          obsecured: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: margin),
                      child: FadeAnimation(
                        offsetY: 50,
                        childWidget: CustomButton(
                          titleButton: 'Sign Up',
                          ontap: () {
                            Get.offNamed('/signIn-student');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    FadeAnimation(
                      offsetY: 50,
                      childWidget: GestureDetector(
                        onTap: () {
                          Get.offNamed('/signIn-teacher');
                        },
                        child: RichText(
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
                      ),
                    ),
                    const SizedBox(height: 8),
                    FadeAnimation(
                      offsetY: 50,
                      childWidget: GestureDetector(
                        onTap: () {
                          Get.off(SignInStudent(),
                              transition: Transition.downToUp,
                              duration: const Duration(seconds: 2));
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "already have an account! ",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: secondaryColor),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Sign In',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
