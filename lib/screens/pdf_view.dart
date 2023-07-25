import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfView extends StatelessWidget {
  final String fileName;
  const PdfView({super.key, required this.fileName});

  @override
  Widget build(BuildContext context) {
    return PDFView(
      filePath: 'storage/emulated/0/Download/$fileName',
      enableSwipe: true,
      swipeHorizontal: true,
      autoSpacing: false,
      pageFling: false,
    );
  }
}
