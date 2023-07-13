import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/animation/fade_animation.dart';
import 'package:lms_app_tugbes/screens/sign_in_page_student.dart';
import 'package:lms_app_tugbes/screens/sign_in_teacher_page.dart';
import 'package:lms_app_tugbes/services/auth_services.dart';
import 'package:lms_app_tugbes/services/query_collection.dart';
import 'package:lms_app_tugbes/shared/theme.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';
import 'package:lms_app_tugbes/widgets/widget_textfield.dart';

class SignUpStudent extends StatefulWidget {
  const SignUpStudent({super.key});

  @override
  State<SignUpStudent> createState() => _SignUpStudentState();
}

class _SignUpStudentState extends State<SignUpStudent>
    with SingleTickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nisController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController validationController = TextEditingController();
  final _formState = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    nisController.dispose();
    emailController.dispose();
    passwordController.dispose();
    validationController.dispose();
    super.dispose();
  }

  void clearText() {
    Future.delayed(const Duration(seconds: 2), () {
      emailController.text = '';
      passwordController.text = '';
      validationController.text = '';
      nisController.text = '';
      nameController.text = '';
    });
  }

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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: SingleChildScrollView(
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
                              Text('Welcome back',
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              const SizedBox(height: 8),
                              Text(
                                'Sign in as a student',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: secondaryColor, fontSize: 16),
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
                        const SizedBox(height: 24),
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
                              controller: nameController,
                              titleTextfield: 'Full Name',
                              hintText: 'Enter your name',
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
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
                        const SizedBox(height: 24),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: margin),
                          child: FadeAnimation(
                            childWidget: CustomTextfield(
                              controller: validationController,
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
                              width: double.infinity,
                              titleButton: 'Sign Up',
                              ontap: () async {
                                if (_formState.currentState!.validate()) {
                                  addStudent(
                                      email: emailController.text,
                                      nama: nameController.text,
                                      nis: nisController.text,
                                      codeClass: '');

                                  AuthServices.signUp(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    validate: validationController.text,
                                    collection: 'siswa',
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        FadeAnimation(
                          offsetY: 50,
                          childWidget: GestureDetector(
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
                        ),
                        const SizedBox(height: 8),
                        FadeAnimation(
                          offsetY: 50,
                          childWidget: GestureDetector(
                            onTap: () {
                              Get.off(
                                const SignInStudent(),
                                transition: Transition.fade,
                                duration: const Duration(seconds: 1),
                              );
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
