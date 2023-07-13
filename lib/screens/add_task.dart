import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/services/query_collection.dart';
import 'package:lms_app_tugbes/services/date.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';
import 'package:lms_app_tugbes/widgets/widget_textfield.dart';

import '../shared/theme.dart';

class AddTaskPage extends StatefulWidget {
  final String titleModule;
  final String learningCode;
  final String classCode;
  const AddTaskPage({
    super.key,
    this.titleModule = "",
    required this.learningCode,
    required this.classCode,
  });

  @override
  State<AddTaskPage> createState() => AddTaskPageState();
}

class AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController dscController = TextEditingController();
  final _formStateTask = GlobalKey<FormState>();
  @override
  void dispose() {
    dscController.dispose();
    super.dispose();
  }

  TimeOfDay _timeOfDay = const TimeOfDay(hour: 8, minute: 12);

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }

  String selectedFileName = 'Upload File';
  Future<void> pickAndUploadFile({String? folder}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
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

  late String dateResult;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(margin, 52, margin, 0),
        child: SingleChildScrollView(
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
                  widget.titleModule == ""
                      ? Text(
                          "Task",
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      : Text(
                          widget.titleModule,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                  const SizedBox(),
                ],
              ),
              const SizedBox(height: 24),
              Form(
                key: _formStateTask,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextfield(
                      controller: dscController,
                      titleTextfield: 'Description',
                      hintText: 'Tugas pengganti kelas',
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showTimePicker();
                          },
                          child: Text(
                            _timeOfDay.format(context).toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: semiBold),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Tanggal.showDate(context, (year, month, day) {
                              setState(() {
                                Tanggal.day;
                                Tanggal.month;
                                Tanggal.year;
                              });
                              dateResult =
                                  "${Tanggal.day.toString()}-${Tanggal.month.toString()}-${Tanggal.year.toString()},${_timeOfDay.format(context).toString()}";
                            });
                          },
                          child: Text(
                            ',  ${Tanggal.day}-${Tanggal.month}-${Tanggal.year}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        pickAndUploadFile(folder: 'tugas');
                      },
                      child:
                          ButtonUploadFile(selectedFileName: selectedFileName),
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      ontap: () {
                        if (_formStateTask.currentState!.validate()) {
                          final String codeTask = generateCode(5);
                          addTask(
                            dsc: dscController.text,
                            codeTask: codeTask,
                            classCode: widget.classCode,
                            deadline: dateResult,
                            fileName: selectedFileName,
                          );
                          Get.back();
                        }
                      },
                      titleButton: 'Upload',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
