import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/services/query_collection.dart';
import 'package:lms_app_tugbes/services/date.dart';
import 'package:lms_app_tugbes/shared/theme.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';

class AnswerPage extends StatefulWidget {
  final String dsc;
  final String email;
  final String deadline;
  final String taskCode;
  const AnswerPage({
    super.key,
    required this.email,
    required this.dsc,
    required this.deadline,
    required this.taskCode,
  });

  @override
  State<AnswerPage> createState() => AnswerPageState();
}

class AnswerPageState extends State<AnswerPage> {
  String selectedFileName = 'Upload File';
  Future<void> pickAndUploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);

      if (mounted) {
        setState(() {
          selectedFileName = file.path.split('/').last;
        });
      }
      print('File dipilih: ${file.path}');
    } else {
      print('Tidak ada file yang dipilih');
    }
  }

  @override
  bool isVisible = false;
  Widget build(BuildContext context) {
    TimeRemaining timeRemaining = TimeRemaining();
    String countdown = timeRemaining.calculateCountdown(widget.deadline);
    bool isBeforeNow = isDateBeforeNow(widget.deadline);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SizedBox(height: 60),
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
                      'Answer',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: margin),
                padding: EdgeInsets.symmetric(horizontal: margin, vertical: 16),
                // height: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 50,
                      offset: const Offset(0, 0),
                      color: secondaryColor.withOpacity(.13),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      child: Text(
                        widget.dsc,
                        overflow: isVisible == true
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: secondaryColor,
                            ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Time remaining',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    isBeforeNow
                        ? Text(
                            countdown,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: redColor),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 16),
                    isBeforeNow
                        ? GestureDetector(
                            onTap: () {
                              pickAndUploadFile();
                            },
                            child: DottedBorder(
                              dashPattern: const [5, 6],
                              strokeCap: StrokeCap.round,
                              color: secondaryColor.withOpacity(.4),
                              strokeWidth: 2,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(12),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                width: double.infinity,
                                height: 42,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          selectedFileName,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                fontSize: 16,
                                                color: secondaryColor,
                                                fontWeight: semiBold,
                                              ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Icon(Icons.add, color: secondaryColor),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 16),
                    isBeforeNow
                        ? FutureBuilder(
                            future: getUser(
                                collection: 'siswa', email: widget.email),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                String nis = snapshot.data!['nis'];
                                return CustomButton(
                                  ontap: () {
                                    submitAnAnswer(
                                        nameFile: selectedFileName,
                                        nis: nis,
                                        taskCode: widget.taskCode);
                                  },
                                  titleButton: 'Submit Task',
                                );
                              } else {
                                return const Text('Belum bisa upload jawaban');
                              }
                            },
                          )
                        : const Text('Waktu pengenjaan sudah selesai'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
