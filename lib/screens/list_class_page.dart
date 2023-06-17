import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/animation/fade_animation.dart';

import '../shared/theme.dart';

class ListClassPage extends StatelessWidget {
  const ListClassPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryOfHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SizedBox(
          height: 60,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                const Spacer(),
                Text(
                  'Your Class',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
              ],
            ),
          ),
          const SizedBox(height: 40),
          FadeAnimation(
            offsetY: 100,
            childWidget: Container(
              width: double.infinity,
              height: mediaQueryOfHeight * .7,
              margin: EdgeInsets.symmetric(horizontal: margin),
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: 5,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: index == 0
                        ? const EdgeInsets.only(top: 0)
                        : const EdgeInsets.only(top: 16),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed('/list-module-student');
                      },
                      child: const CardClass(
                        lessonName: 'Math',
                        teachersName: 'Yati S.Pd',
                        description: 'Module 6',
                        theNumberOfStudent: 21,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardClass extends StatelessWidget {
  final String lessonName;
  final String description;
  final String teachersName;
  final int theNumberOfStudent;
  const CardClass({
    super.key,
    required this.lessonName,
    required this.description,
    required this.teachersName,
    required this.theNumberOfStudent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: blueColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(5, 5),
            color: Colors.black.withOpacity(.2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                lessonName,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: semiBold, color: whiteColor),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xff4647FF),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteColor,
                      ),
                      child: Icon(Icons.school_rounded,
                          color: primaryColor, size: 18),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      theNumberOfStudent.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: whiteColor, fontWeight: semiBold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: whiteColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const Spacer(),
          Text(
            teachersName,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: whiteColor),
          ),
        ],
      ),
    );
  }
}
