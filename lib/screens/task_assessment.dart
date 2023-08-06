import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/screens/pdf_view.dart';
import 'package:lms_app_tugbes/services/query_collection.dart';
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
                Row(
                  children: [
                    SvgPicture.asset('assets/pdf.svg', width: 24),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        Get.to(PdfView(fileName: fileName));
                      },
                      child: SizedBox(
                        width: 250,
                        child: Text(
                          fileName,
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
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
