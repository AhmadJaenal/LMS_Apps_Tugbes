import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';

import 'package:lms_app_tugbes/services/query_collection.dart';

class PdfView extends StatelessWidget {
  final String fileName;
  final String folderDownload;
  const PdfView(
      {super.key, required this.fileName, required this.folderDownload});

  @override
  Widget build(BuildContext context) {
    String filePath = 'storage/emulated/0/Download/$fileName';

    File file = File(filePath);

    if (file.existsSync()) {
      return PDFView(
        filePath: filePath,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
      );
    } else {
      downloadFile(fileUrl: fileName, folder: folderDownload);
      return Center(
        child: CircularProgressIndicator(), // Tampilkan indikator loading
      );
    }
  }
}
