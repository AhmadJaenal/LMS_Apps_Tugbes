import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/animation/fade_animation.dart';
import 'package:lms_app_tugbes/widgets/card_class.dart';

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
            child: Center(
              child: Text(
                'Your Class',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          const SizedBox(height: 40),
          FadeAnimation(
            offsetY: 100,
            childWidget: Container(
              width: double.infinity,
              height: mediaQueryOfHeight * .7,
              margin: EdgeInsets.symmetric(horizontal: margin),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 50,
                    offset: const Offset(0, 0),
                    color: secondaryColor.withOpacity(.13),
                  ),
                ],
              ),
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
                      child: CardClass(
                        className: 'RPL 2',
                        lessonName: 'Math',
                        onTap: () {},
                        teachersName: 'Yati Hariyati S.Pd',
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
