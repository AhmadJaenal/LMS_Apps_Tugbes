import 'package:flutter/material.dart';
import 'package:lms_app_tugbes/shared/theme.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';
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
  // final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SizedBox(height: 30),
      ),
      body: Column(
        children: [
          const SizedBox(height: 32),
          const ButtonBack(title: 'Penilaian Tugas'),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nis,
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
                const SizedBox(height: 8),
                Text(
                  fileName,
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
                const SizedBox(height: 8),
                TextFieldOnChange(
                  controller: gradeController,
                  fileName: fileName,
                  nis: nis,
                  taskCode: taskCode,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 50,
                        offset: const Offset(10, 10),
                        color: secondaryColor.withOpacity(.13),
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height * .6,
                  // child: SfPdfViewer.network(
                  //   "https://console.firebase.google.com/project/fir-lms-app/storage/fir-lms-app.appspot.com/tugas/Temp Tugas5.pdf",
                  //   key: _pdfViewerKey,
                  // ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
