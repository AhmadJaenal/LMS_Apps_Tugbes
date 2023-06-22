import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';
import 'package:lms_app_tugbes/widgets/widget_textfield.dart';

import '../shared/theme.dart';

class DetailModuleTeacher extends StatelessWidget {
  final String titleModule;
  const DetailModuleTeacher({super.key, required this.titleModule});

  @override
  Widget build(BuildContext context) {
    final textEditingControllerTitleModule = TextEditingController();
    final textEditingControllerDsc = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: margin, vertical: 42),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                titleModule == ""
                    ? Text(
                        "Upload Module",
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    : Text(
                        titleModule,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                const SizedBox(),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              'Module 1',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: medium, fontSize: 16),
            ),
            const SizedBox(height: 16),
            CustomTextfield(
              controller: textEditingControllerTitleModule,
              titleTextfield: 'Title Module',
              hintText: 'Add Title Module',
            ),
            const SizedBox(height: 16),
            CustomTextfield(
              controller: textEditingControllerDsc,
              titleTextfield: 'Description',
              hintText: 'Add Description',
            ),
            const SizedBox(height: 16),
            DottedBorder(
              dashPattern: const [5, 6],
              strokeCap: StrokeCap.round,
              color: secondaryColor.withOpacity(.4),
              strokeWidth: 2,
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              child: Container(
                width: 150,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Upload File',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 16,
                              color: secondaryColor,
                              fontWeight: semiBold,
                            ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.add, color: secondaryColor),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              ontap: () {},
              titleButton: 'Upload',
            ),
          ],
        ),
      ),
    );
  }
}
