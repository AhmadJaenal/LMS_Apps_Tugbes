import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shared/theme.dart';

class DetailModuleStudent extends StatelessWidget {
  final String titleModule;
  const DetailModuleStudent({super.key, required this.titleModule});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SizedBox(height: 60),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: margin),
            child: Row(
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
          ),
        ],
      ),
    );
  }
}
