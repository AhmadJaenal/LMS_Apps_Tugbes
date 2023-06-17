import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lms_app_tugbes/animation/fade_animation.dart';
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
        backgroundColor: whiteColor,
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
                              return CustomPopUp(
                                controller: idClassController,
                                hintText: 'Add link class',
                                titleButton: 'Join',
                                titlePopUp: 'Add Class',
                                onTap: () {
                                  Get.back();
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const CustomPopUpNotif(
                                        title: 'Success Join',
                                        desc:
                                            'You have successfully\njoined this class',
                                        icon: 'icon_success.svg',
                                      );
                                    },
                                  );
                                },
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FadeAnimation(
                          offsetX: -100,
                          childWidget: Text('Your Class',
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/list-page');
                          },
                          child: FadeAnimation(
                            offsetX: 50,
                            childWidget: Text(
                              'View all',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: primaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: FadeAnimation(
                      offsetX: 100,
                      childWidget: Container(
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
                                      ? const EdgeInsets.only(
                                          right: 24, left: 16)
                                      : const EdgeInsets.only(left: 16),
                              child: CardClass(
                                className: 'RPL 2',
                                teachersName: 'yati',
                                color: blueColor,
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
                          child: FadeAnimation(
                            offsetY: 200,
                            childWidget: const CardTask(
                              lessonName: 'Math',
                              schedule: 'Modul 5',
                              teachersName: 'Yati S.Pd',
                              time: '09:00-11:00',
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
        floatingActionButton: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 17),
                blurRadius: 215,
                color: const Color(0xff7281DF).withOpacity(.12),
              ),
              BoxShadow(
                offset: const Offset(0, 3.84),
                blurRadius: 22.2,
                color: const Color(0xff7281DF).withOpacity(.08),
              ),
            ],
          ),
          child: GNav(
            activeColor: blueColor,
            color: secondaryColor,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 50),
            tabs: const [
              GButton(
                icon: Icons.home_filled,
              ),
              GButton(
                icon: Icons.school_rounded,
              ),
              GButton(
                icon: Icons.person_2_rounded,
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
