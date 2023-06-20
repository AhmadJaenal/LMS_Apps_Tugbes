import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<void> pickAndUploadFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    File file = File(result.files.single.path!);
  } else {
    print('Tidak ada file yang dipilih');
  }
}
