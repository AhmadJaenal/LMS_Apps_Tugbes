import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/animation/fade_animation.dart';
import 'package:lms_app_tugbes/widgets/widget_module_card.dart';

import '../shared/theme.dart';
import 'detail_module_student_page.dart';

class ListModuleStudent extends StatefulWidget {
  const ListModuleStudent({super.key});

  @override
  State<ListModuleStudent> createState() => _ListModuleStudentState();
}

class _ListModuleStudentState extends State<ListModuleStudent> {
  List<String> module = [
    "Matematika Diskrit",
    "Uji Hipotesa",
    "Pengujian Nuklir",
    "Tata Surya",
    "Prakterk Operasi Jantung",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  ];

  @override
  bool isClicked = false;
  Widget build(BuildContext context) {
    final mediaQueryOfHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SizedBox(
          height: 60,
        ),
      ),
      body: Stack(
        children: [
          Align(
              alignment: const Alignment(1, 4),
              child: SvgPicture.asset(
                'assets/pattern.svg',
                fit: BoxFit.cover,
              )),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: margin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: blueColor,
                        ),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: whiteColor,
                          size: 16,
                        ),
                      ),
                    ),
                    Text(
                      'Math',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              FadeAnimation(
                offsetY: 100,
                childWidget: Container(
                  padding: EdgeInsets.symmetric(horizontal: margin),
                  width: double.infinity,
                  height: mediaQueryOfHeight * .8,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding: index == 0
                            ? const EdgeInsets.only(top: 0)
                            : const EdgeInsets.only(top: 16),
                        child: ModuleCard(
                          onTap: () {
                            setState(() {
                              isClicked = !isClicked;
                            });
                            Get.to(
                              DetailModuleStudent(titleModule: module[index]),
                            );
                          },
                          isClicked: isClicked,
                          isTeacher: true,
                          meetingList: index + 1,
                          titleModule: module[index],
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
