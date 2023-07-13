import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/shared/theme.dart';
import 'package:lms_app_tugbes/widgets/widget_textfield.dart';

class TaskAssessment extends StatelessWidget {
  final String taskCode;
  final String nis;
  final String fileName;

  TaskAssessment({
    super.key,
    required this.taskCode,
    required this.nis,
    required this.fileName,
  });
  final TextEditingController gradeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  'Task Assessment',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nis),
                Text(fileName),
                TextFieldOnChange(
                  controller: gradeController,
                  fileName: fileName,
                  nis: nis,
                  taskCode: taskCode,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
