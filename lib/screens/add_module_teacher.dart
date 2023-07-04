import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/services/collection.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';
import 'package:lms_app_tugbes/widgets/widget_textfield.dart';

import '../shared/theme.dart';

class AddModuleTeacher extends StatefulWidget {
  final String titleModule;
  final String learningCode;
  const AddModuleTeacher(
      {super.key, this.titleModule = "", required this.learningCode});

  @override
  State<AddModuleTeacher> createState() => AddModuleTeacherState();
}

class AddModuleTeacherState extends State<AddModuleTeacher> {
  final TextEditingController moduleController = TextEditingController();
  final TextEditingController dscController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final _formState = GlobalKey<FormState>();
  @override
  void dispose() {
    moduleController.dispose();
    dscController.dispose();
    titleController.dispose();
    super.dispose();
  }

  String selectedFileName = 'Upload File';
  Future<void> pickAndUploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    late File file;
    if (result != null) {
      file = File(result.files.single.path!);
      if (mounted) {
        setState(() {
          selectedFileName = file.path.split('/').last;
        });
      }
      uploadFile(nameFile: selectedFileName, file: file);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(margin, 52, margin, 0),
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formState,
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
                            "Upload Module",
                            style: Theme.of(context).textTheme.titleLarge,
                          )
                        : Text(
                            widget.titleModule,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                    const SizedBox(),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  'Module',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: medium, fontSize: 16),
                ),
                const SizedBox(height: 16),
                CustomTextfield(
                  controller: moduleController,
                  titleTextfield: 'Module',
                  hintText: 'Pertemuan ke-',
                ),
                const SizedBox(height: 16),
                CustomTextfield(
                  controller: dscController,
                  titleTextfield: 'Description',
                  hintText: 'Pelajari materi berikut',
                ),
                const SizedBox(height: 16),
                CustomTextfield(
                  controller: titleController,
                  titleTextfield: 'Title Module',
                  hintText: 'Matriks dan Determinan',
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    pickAndUploadFile();
                  },
                  child: ButtonUploadFile(selectedFileName: selectedFileName),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  ontap: () {
                    if (_formState.currentState!.validate()) {
                      updateMateri(
                        learningCode: widget.learningCode,
                        chapter: moduleController.text,
                        dsc: dscController.text,
                        title: titleController.text,
                        nameFile: selectedFileName,
                      );
                      Get.back();
                    }
                  },
                  titleButton: 'Upload',
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    'Task',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 32),
                CustomTextfield(
                  controller: moduleController,
                  titleTextfield: 'Description',
                  hintText: 'Tugas pengganti kelas',
                ),
                const SizedBox(height: 16),
                CustomTextfield(
                  controller: moduleController,
                  titleTextfield: 'Module',
                  hintText: 'Pertemuan ke-',
                ),
                const SizedBox(height: 16),
                CustomTextfield(
                  controller: moduleController,
                  titleTextfield: 'Module',
                  hintText: 'Pertemuan ke-',
                ),
                const SizedBox(height: 16),
                CustomTextfield(
                  controller: moduleController,
                  titleTextfield: 'Module',
                  hintText: 'Pertemuan ke-',
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
