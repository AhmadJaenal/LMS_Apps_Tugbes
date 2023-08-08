import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/animation/fade_animation.dart';
import 'package:lms_app_tugbes/screens/sign_in_page_student.dart';
import 'package:lms_app_tugbes/services/auth_services.dart';
import 'package:lms_app_tugbes/services/query_collection.dart';
import 'package:lms_app_tugbes/shared/theme.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';
import 'package:lms_app_tugbes/widgets/widget_textfield.dart';

import 'sign_in_teacher_page.dart';

class SignUpTeacher extends StatefulWidget {
  const SignUpTeacher({super.key});

  @override
  State<SignUpTeacher> createState() => _SignUpTeacherState();
}

class _SignUpTeacherState extends State<SignUpTeacher>
    with SingleTickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nipController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController validationController = TextEditingController();
  final TextEditingController classNameController = TextEditingController();
  final TextEditingController lessonNameController = TextEditingController();
  final _formState = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    nipController.dispose();
    emailController.dispose();
    passwordController.dispose();
    validationController.dispose();
    classNameController.dispose();
    lessonNameController.dispose();
    super.dispose();
  }

  void clearText() {
    Future.delayed(const Duration(seconds: 5), () {
      emailController.text = '';
      passwordController.text = '';
      validationController.text = '';
      nipController.text = '';
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
                  child: SvgPicture.asset(
                    'assets/pattern.svg',
                    fit: BoxFit.cover,
                  )),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
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
                              Text('Selamat datang',
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              const SizedBox(height: 8),
                              Text(
                                'Daftar sebagai guru',
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
                              controller: nipController,
                              titleTextfield: 'NIP',
                              hintText: 'Masukan NIP',
                              isNumber: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: margin),
                          child: FadeAnimation(
                            childWidget: CustomTextfield(
                              controller: nameController,
                              titleTextfield: 'Nama',
                              hintText: 'Masukan nama',
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
                              hintText: 'Masukan email',
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
                              hintText: 'Masukan password',
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
                              hintText: 'Password',
                              obsecured: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: margin),
                          child: FadeAnimation(
                            childWidget: CustomButton(
                              width: double.infinity,
                              titleButton: 'Daftar',
                              ontap: () {
                                addTeacher(
                                  codeClass: '',
                                  email: emailController.text,
                                  name: nameController.text,
                                  nip: nipController.text,
                                );
                                if (_formState.currentState!.validate()) {
                                  AuthServices.signUp(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    validate: validationController.text,
                                    collection: 'guru',
                                    isTeacher: true,
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
                                const SignInStudent(),
                                transition: Transition.fade,
                                duration: const Duration(seconds: 1),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Masuk sebagai ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: secondaryColor),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'siswa',
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
                                SignInTeacher(),
                                transition: Transition.fade,
                                duration: const Duration(seconds: 1),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "Sudah memiliki akun!  ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: secondaryColor),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Masuk',
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
