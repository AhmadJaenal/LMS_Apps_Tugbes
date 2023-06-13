import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/shared/theme.dart';
import 'package:lms_app_tugbes/widgets/card_class.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';
import 'package:lms_app_tugbes/widgets/widget_textfield.dart';

class DashboardTeacher extends StatelessWidget {
  DashboardTeacher({super.key});

  TextEditingController idClassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQueryOfWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Stack(
          children: [
            Align(
                alignment: const Alignment(1, 4),
                child: SvgPicture.asset(
                  'assets/pattern.svg',
                  fit: BoxFit.cover,
                )),
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
                              return AlertDialog(
                                actions: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.link,
                                                color: primaryColor,
                                                weight: 24),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Create Class',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: primaryColor,
                                                      fontSize: 18,
                                                      fontWeight: semiBold),
                                            )
                                          ],
                                        ),
                                        CustomTextfield(
                                          controller: idClassController,
                                          hintText: 'Add Name Class',
                                          titleTextfield: '',
                                        ),
                                        const SizedBox(height: 16),
                                        CustomButtonClass(
                                          isBig: true,
                                          titleButton: 'Create',
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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

class CardTask extends StatelessWidget {
  final String lessonName;
  final String teachersName;
  final String schedule;
  final String time;
  const CardTask({
    super.key,
    required this.lessonName,
    required this.teachersName,
    required this.schedule,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      height: 137,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: secondaryColor.withOpacity(0.3), width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$lessonName\n$schedule',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: regular, fontSize: 20)),
              const Icon(Icons.arrow_forward_ios_rounded),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(teachersName,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: regular, fontSize: 18)),
              Text(time,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: regular, fontSize: 18)),
            ],
          ),
        ],
      ),
    );
  }
}
