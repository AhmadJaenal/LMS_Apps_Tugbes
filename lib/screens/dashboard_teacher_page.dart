import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/shared/theme.dart';
import 'package:lms_app_tugbes/widgets/card_class.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';
import 'package:lms_app_tugbes/widgets/widget_pop_up.dart';
import 'package:lms_app_tugbes/widgets/widget_task.dart';

class DashboardTeacher extends StatefulWidget {
  DashboardTeacher({super.key});

  @override
  State<DashboardTeacher> createState() => _DashboardTeacherState();
}

class _DashboardTeacherState extends State<DashboardTeacher> {
  TextEditingController nameClassController = TextEditingController();

  @override
  void dispose() {
    nameClassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryOfWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: SizedBox(height: 30),
        ),
        backgroundColor: whiteColor,
        body: Stack(
          children: [
            Align(
              alignment: const Alignment(1, 4),
              child: SvgPicture.asset(
                'assets/pattern.svg',
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: margin),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Welcome back sir',
                                style: Theme.of(context).textTheme.bodySmall),
                            Text('Nastar',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: blueColor,
                          ),
                          child: Icon(Icons.person_outline_rounded,
                              color: whiteColor, size: 14, weight: 3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: margin),
                    child: CustomButtonClass(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomPopUp(
                                controller: nameClassController,
                                hintText: 'Add name class',
                                titleButton: 'Create',
                                titlePopUp: 'Create Class',
                                onTap: () {
                                  String codeClass = generateRandomCode(10);
                                  Get.back();
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomPopUpNotif(
                                        title: 'Success Create Class',
                                        desc:
                                            'Classroom has been successfully created share this code\n"$codeClass"\nto invite others to join',
                                        icon: 'icon_success.svg',
                                      );
                                    },
                                  );
                                },
                              );
                            });
                      },
                      titleButton: 'Create Class',
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: margin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Your Class',
                            style: Theme.of(context).textTheme.titleLarge),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/list-page');
                          },
                          child: Text(
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: mediaQueryOfWidth,
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: index == 0
                                ? const EdgeInsets.only(left: 24)
                                : index == 4
                                    ? const EdgeInsets.only(right: 24, left: 16)
                                    : const EdgeInsets.only(left: 16),
                            child: CardClass(
                              className: 'RPL 2',
                              teachersName: 'yati',
                              color: blueColor,
                              lessonName: 'Math',
                              theNumberOfStudent: 21,
                              onTap: () {
                                Get.toNamed('/list-module-teacher');
                              },
                            ),
                          );
                        },
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
                        Text('Task',
                            style: Theme.of(context).textTheme.titleLarge),
                        Text(
                          'View all',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: margin),
                    width: double.infinity,
                    height: 400,
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: index == 0
                              ? const EdgeInsets.only(top: 0)
                              : const EdgeInsets.only(top: 16),
                          child: const CardTask(
                            lessonName: 'Math',
                            schedule: 'Modul 5',
                            teachersName: 'Yati S.Pd',
                            time: '09:00-11:00',
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String generateRandomCode(int length) {
  final random = Random();
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final codeUnits =
      List.generate(length, (index) => chars[random.nextInt(chars.length)]);

  return codeUnits.join('');
}
