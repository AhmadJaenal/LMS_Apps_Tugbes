import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/services/query_collection.dart';
import 'package:lms_app_tugbes/shared/theme.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';
import 'package:lms_app_tugbes/widgets/widget_pop_up.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
  final String nis;
  final String email;
  const QRScanner({super.key, required this.nis, required this.email});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: primaryColor,
              borderRadius: 15,
              borderLength: 60,
              borderWidth: 7,
              cutOutSize: MediaQuery.of(context).size.width * 0.8,
            ),
          ),
          if (result != null)
            Positioned(
              bottom: 50,
              child: CustomButton(
                  titleButton: 'Gabung',
                  ontap: () {
                    searchDocument(
                            nameCollection: 'kelas',
                            data: 'code_kelas',
                            searchQuery: result!.code)
                        .listen((snapshot) {
                      if (snapshot.docs.isNotEmpty) {
                        addListStudent(
                            codeClass: result!.code, nis: widget.nis);
                        updateClass(
                          codeClass: result!.code,
                          collection: 'siswa',
                          email: widget.email,
                        );
                        ScaffoldMessenger.of(Get.context!).showSnackBar(
                          customSnackbar(
                              message: "Berhasil bergabung kelas",
                              isError: false),
                        );
                      } else {
                        ScaffoldMessenger.of(Get.context!).showSnackBar(
                          customSnackbar(
                            message: "Gagal bergabung kelas",
                          ),
                        );
                      }
                    });
                    Get.back();
                  }),
            ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
