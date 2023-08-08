import 'package:flutter/material.dart';
import 'package:lms_app_tugbes/shared/theme.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCode extends StatelessWidget {
  final String code;
  const QRCode({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      width: 20,
      height: 300,
      decoration: BoxDecoration(color: whiteColor),
      child: Stack(
        children: [
          // Transform.translate(
          //   offset: const Offset(0, -180),
          //   child: Center(
          //     child: Container(
          //       width: 100,
          //       height: 100,
          //       decoration: BoxDecoration(
          //         color: whiteColor,
          //         shape: BoxShape.circle,
          //         image: const DecorationImage(
          //           image: AssetImage('assets/image_profile.png'),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 40),
              Center(
                child: QrImageView(
                  data: code,
                  version: QrVersions.auto,
                  size: 180,
                  gapless: false,
                  embeddedImage: const AssetImage('assets/app_logo.png'),
                  embeddedImageStyle: QrEmbeddedImageStyle(
                    size: const Size(60, 80),
                  ),
                ),
              ),
              const Spacer(),
              Text('Scan Here', style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ],
      ),
    );
  }
}
