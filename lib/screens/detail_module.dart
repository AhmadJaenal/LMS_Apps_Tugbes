import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/services/collection.dart';

import '../shared/theme.dart';

class DetailModule extends StatelessWidget {
  final String titleModule;
  final String dsc;
  final String nameFile;
  const DetailModule(
      {super.key,
      required this.titleModule,
      required this.dsc,
      required this.nameFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SizedBox(height: 60),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: margin),
        child: Column(
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
                Text(
                  titleModule,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: whiteColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 50,
                    offset: const Offset(0, 0),
                    color: secondaryColor.withOpacity(.13),
                  ),
                ],
              ),
              child: Text(dsc, style: Theme.of(context).textTheme.bodyMedium),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: whiteColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 50,
                    offset: const Offset(0, 0),
                    color: secondaryColor.withOpacity(.13),
                  ),
                ],
              ),
              child: Row(
                children: [
                  SvgPicture.asset('assets/pdf.svg', width: 24),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      downloadFile(fileUrl: nameFile);
                    },
                    child: SizedBox(
                      width: 250,
                      child: Text(
                        nameFile,
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
