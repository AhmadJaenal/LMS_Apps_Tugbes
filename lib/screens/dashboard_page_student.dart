import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/animation/fade_animation.dart';
import 'package:lms_app_tugbes/controller/url_launcher.dart';
import 'package:lms_app_tugbes/screens/detail_task_page.dart';
import 'package:lms_app_tugbes/shared/theme.dart';
import 'package:lms_app_tugbes/widgets/card_class.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';
import 'package:lms_app_tugbes/widgets/widget_pop_up.dart';
import 'package:lms_app_tugbes/widgets/widget_task.dart';

class DashboardStudent extends StatefulWidget {
  const DashboardStudent({super.key});

  @override
  State<DashboardStudent> createState() => _DashboardStudentState();
}

class _DashboardStudentState extends State<DashboardStudent> {
  TextEditingController idClassController = TextEditingController();
  final _formState = GlobalKey<FormState>();

  @override
  void dispose() {
    idClassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isVisible = false;
    final mediaQueryOfWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryColor.withOpacity(.01),
        body: Stack(
          children: [
            FadeAnimation(
              childWidget: Align(
                alignment: const Alignment(1, 4),
                child: SvgPicture.asset(
                  'assets/pattern.svg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 42),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: margin),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FadeAnimation(
                          offsetX: -100,
                          childWidget: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Welcome back',
                                  style: Theme.of(context).textTheme.bodySmall),
                              Text('Jonua',
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                        ),
                        FadeAnimation(
                          offsetX: 100,
                          childWidget: Container(
                            width: 42,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: blueColor,
                              ),
                              child: Icon(Icons.person_outline_rounded,
                                  color: whiteColor, size: 14, weight: 3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: margin),
                    child: FadeAnimation(
                      offsetX: -100,
                      childWidget: CustomButtonClass(
                        onTap: () {
                          return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Form(
                                autovalidateMode: AutovalidateMode.always,
                                key: _formState,
                                child: CustomPopUp(
                                  controller: idClassController,
                                  hintText: 'Add link class',
                                  titleButton: 'Join',
                                  titlePopUp: 'Add Class',
                                  onTap: () {
                                    if (_formState.currentState!.validate()) {
                                      Get.back();
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomPopUpNotif(
                                            title: 'Success Join',
                                            desc:
                                                'You have successfully\njoined this class',
                                            icon: 'icon_success.svg',
                                            ontap: () {
                                              openWhatsApp("089663774293");
                                            },
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              );
                            },
                          );
                        },
                        titleButton: 'Join Class',
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: margin),
                    child: FadeAnimation(
                      offsetX: -100,
                      childWidget: Text('Your Class',
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: FadeAnimation(
                      offsetX: 100,
                      childWidget: Container(
                        width: mediaQueryOfWidth,
                        height: 120,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 50,
                              offset: const Offset(0, 0),
                              color: secondaryColor.withOpacity(.13),
                            ),
                          ],
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: index == 0
                                  ? const EdgeInsets.only(left: 16)
                                  : index == 4
                                      ? const EdgeInsets.only(
                                          right: 24, left: 16)
                                      : const EdgeInsets.only(left: 16),
                              child: CardClass(
                                className: 'RPL 2',
                                teachersName: 'yati',
                                lessonName: 'Math',
                                theNumberOfStudent: 21,
                                onTap: () {
                                  Get.toNamed('/list-module-student');
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: margin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FadeAnimation(
                          offsetX: -50,
                          childWidget: Text('Task',
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                        FadeAnimation(
                          offsetX: 50,
                          childWidget: Text(
                            'View all',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: 400,
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: index == 0
                              ? const EdgeInsets.only(top: 0)
                              : const EdgeInsets.only(top: 16),
                          child: FadeAnimation(
                            offsetY: 100,
                            childWidget: CardTask(
                              lessonName: 'Software analysis',
                              titleTask:
                                  'Analisis kebutuhan sistem perangkat lunak',
                              teachersName: 'Yati S.Pd',
                              time: '09:00-11:00',
                              ontap: () {
                                Get.to(const DetailTask(
                                  lessonName: 'Software analysis',
                                  desc:
                                      "Tugas ini adalah tentang pengembangan aplikasi sederhana menggunakan Flutter, sebuah kerangka kerja (framework) yang digunakan untuk membuat aplikasi lintas platform yang indah dan responsif. Anda diminta untuk membuat aplikasi To-Do List yang memungkinkan pengguna untuk mencatat, mengelola, dan menyelesaikan tugas-tugas mereka.",
                                  time: "09:00-11:00",
                                ));
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
