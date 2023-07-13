import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/screens/add_task.dart';
import 'package:lms_app_tugbes/screens/detail_module.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';
import 'package:lms_app_tugbes/widgets/widget_module_card.dart';

import '../services/query_collection.dart';
import '../shared/theme.dart';
import 'add_module_teacher.dart';

class ListModule extends StatelessWidget {
  final String learningCode;
  final String titleClass;
  final String classCode;
  final bool isTeacher;
  const ListModule({
    super.key,
    required this.learningCode,
    required this.titleClass,
    required this.classCode,
    this.isTeacher = false,
  });

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
                padding: EdgeInsets.symmetric(vertical: 52, horizontal: margin),
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
                      titleClass,
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
                child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: getModule(learningCode: learningCode),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, index) {
                          String chapter = snapshot.data![index]['module'];
                          String titleModule = snapshot.data![index]['title'];
                          String dscModule = snapshot.data![index]['dsc'];
                          String fileName = snapshot.data![index]['name_file'];
                          return Padding(
                            padding: index == 0
                                ? const EdgeInsets.only(top: 0)
                                : const EdgeInsets.only(top: 16),
                            child: ModuleCard(
                              onTap: () {
                                Get.to(
                                  DetailModule(
                                    dsc: dscModule,
                                    titleModule: titleModule,
                                    fileName: fileName,
                                  ),
                                );
                              },
                              isClicked: false,
                              chapter: chapter,
                              titleModule: titleModule,
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: isTeacher
          ? Padding(
              padding:
                  EdgeInsets.symmetric(vertical: margin, horizontal: margin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    ontap: () {
                      Get.to(AddModuleTeacher(learningCode: learningCode));
                    },
                    titleButton: 'Add Module',
                  ),
                  const SizedBox(width: 8),
                  CustomButton(
                    ontap: () {
                      Get.to(AddTaskPage(
                        learningCode: learningCode,
                        classCode: classCode,
                      ));
                    },
                    titleButton: 'Add Task',
                  ),
                ],
              ),
            )
          : const SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
