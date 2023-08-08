import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/screens/page_nilai.dart';
import 'package:lms_app_tugbes/services/query_collection.dart';
import 'package:lms_app_tugbes/services/date.dart';
import 'package:lms_app_tugbes/shared/theme.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';
import 'package:lms_app_tugbes/widgets/widget_pop_up.dart';

class AnswerPage extends StatefulWidget {
  final String dsc;
  final String email;
  final String deadline;
  final String taskCode;
  final String fileName;
  const AnswerPage({
    super.key,
    required this.email,
    required this.dsc,
    required this.deadline,
    required this.taskCode,
    required this.fileName,
  });

  @override
  State<AnswerPage> createState() => AnswerPageState();
}

class AnswerPageState extends State<AnswerPage> {
  String selectedFileName = 'Upload File';
  Future<void> pickAndUploadFile({String? folder}) async {
    // FilePickerResult? result = await FilePicker.platform.pickFiles();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    late File file;
    if (result != null) {
      file = File(result.files.single.path!);
      if (mounted) {
        setState(() {
          selectedFileName = file.path.split('/').last;
        });
      }
      uploadFile(nameFile: selectedFileName, file: file, folder: folder);
    }
  }

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
              const ButtonBack(title: 'Unggah Jawaban'),
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
                      'Deskripsi Tugas',
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
                      'Batas Pengumpulan',
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
                    const SizedBox(height: 8),
                    Text(
                      'File Tugas',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        SvgPicture.asset('assets/pdf.svg', width: 24),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            // Get.to(PdfView(
                            //   fileName: widget.fileName,
                            //   folderDownload: 'tugas',
                            // ));
                            downloadFile(
                                fileUrl: widget.fileName, folder: 'tugas');
                          },
                          child: SizedBox(
                            width: 250,
                            child: Text(
                              widget.fileName,
                              style: Theme.of(context).textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    isBeforeNow
                        ? GestureDetector(
                            onTap: () {
                              pickAndUploadFile(folder: 'tugas');
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
                                    if (selectedFileName != 'Upload File') {
                                      submitAnAnswer(
                                        nameFile: selectedFileName,
                                        nis: nis,
                                        taskCode: widget.taskCode,
                                      );
                                    } else {
                                      return ScaffoldMessenger.of(Get.context!)
                                          .showSnackBar(
                                        customSnackbar(
                                            message: 'File tidak boleh kosong'),
                                      );
                                    }
                                  },
                                  titleButton: 'Submit',
                                );
                              } else {
                                return const Text('Belum bisa upload jawaban');
                              }
                            },
                          )
                        : const Text('Waktu pengerjaan sudah selesai'),
                    const SizedBox(height: 16),
                    CustomButton(
                      titleButton: 'Daftar Nilai',
                      ontap: () {
                        Get.to(Nilai(taskCode: widget.taskCode));
                      },
                    ),
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
