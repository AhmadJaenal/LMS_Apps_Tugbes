import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/animation/fade_animation.dart';
import 'package:lms_app_tugbes/screens/sign_up_page_student.dart';
import 'package:lms_app_tugbes/services/auth_services.dart';
import 'package:lms_app_tugbes/shared/theme.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';
import 'package:lms_app_tugbes/widgets/widget_textfield.dart';

import 'sign_in_teacher_page.dart';

class SignInStudent extends StatefulWidget {
  const SignInStudent({super.key});

  @override
  State<SignInStudent> createState() => _SignInStudentState();
}

class _SignInStudentState extends State<SignInStudent>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formState = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: const Alignment(1, 4),
              child: FadeAnimation(
                childWidget: SvgPicture.asset(
                  'assets/pattern.svg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formState,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeAnimation(
                        offsetY: -100,
                        childWidget: Column(
                          children: [
                            Text(
                              'Welcome back',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Sign in as a student',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: secondaryColor, fontSize: 16),
                            ),
                          ],
                        ),
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
                        child: FadeAnimation(
                          childWidget: CustomTextfield(
                            controller: emailController,
                            titleTextfield: 'Email',
                            hintText: 'Enter your email',
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
                      const SizedBox(height: 32),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin),
                        child: FadeAnimation(
                          offsetY: 50,
                          childWidget: Column(
                            children: [
                              CustomButton(
                                width: double.infinity,
                                titleButton: 'Sign In',
                                ontap: () async {
                                  if (_formState.currentState!.validate()) {
                                    AuthServices.signIn(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      collection: 'siswa',
                                      isTeacher: false,
                                    );
                                  }
                                },
                              ),
                              const SizedBox(height: 24),
                              GestureDetector(
                                onTap: () {
                                  Get.off(
                                    SignInTeacher(),
                                    transition: Transition.fade,
                                    duration: const Duration(seconds: 1),
                                  );
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
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: () {
                                  Get.off(
                                    SignUpStudent(),
                                    transition: Transition.fade,
                                    duration: const Duration(seconds: 1),
                                  );
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
