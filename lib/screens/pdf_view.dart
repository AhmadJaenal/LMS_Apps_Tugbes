import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';

import 'package:lms_app_tugbes/services/query_collection.dart';

class PdfView extends StatefulWidget {
  final String fileName;
  final String folderDownload;
  const PdfView(
      {super.key, required this.fileName, required this.folderDownload});

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  @override
  Widget build(BuildContext context) {
    String filePath = 'storage/emulated/0/Download/${widget.fileName}';
    print(filePath);
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
      downloadFile(fileUrl: widget.fileName, folder: widget.folderDownload);
      setState(() {});
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
