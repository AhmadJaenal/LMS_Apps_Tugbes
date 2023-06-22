import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';
import 'package:lms_app_tugbes/widgets/widget_module_card.dart';

import '../shared/theme.dart';
import 'detail_module_teacher.dart';

class ListModuleTeacher extends StatelessWidget {
  ListModuleTeacher({super.key});

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
  Widget build(BuildContext context) {
    final mediaQueryOfHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
                padding: EdgeInsets.symmetric(vertical: 42, horizontal: margin),
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: margin),
                width: double.infinity,
                height: mediaQueryOfHeight * .7,
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
                          Get.to(DetailModuleTeacher(
                            titleModule: module[index],
                          ));
                        },
                        isClicked: false,
                        meetingList: index + 1,
                        titleModule: module[index],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(vertical: margin, horizontal: margin),
        child: CustomButton(
          ontap: () {},
          titleButton: 'Share Class',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
