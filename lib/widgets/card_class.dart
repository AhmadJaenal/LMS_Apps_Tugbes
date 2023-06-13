import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lms_app_tugbes/shared/theme.dart';

class CardClass extends StatelessWidget {
  final String lessonName;
  final String className;
  final String teachersName;
  final String pattern;
  final int theNumberOfStudent;
  final Color color;
  final Function() onTap;
  const CardClass({
    super.key,
    required this.lessonName,
    required this.className,
    required this.teachersName,
    this.pattern = '',
    required this.theNumberOfStudent,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 150,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
        ),
        child: Stack(
          children: [
            pattern != ''
                ? Transform.translate(
                    offset: const Offset(10, 20),
                    child: SvgPicture.asset('assets/$pattern'),
                  )
                : const SizedBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    width: 70,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: color.withGreen(150)
                        ..withBlue(150)
                        ..withRed(10),
                    ),
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
                        const Spacer(),
                        Text(
                          theNumberOfStudent.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 16,
                                  color: whiteColor,
                                  fontWeight: semiBold),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Text(lessonName,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16, color: whiteColor, fontWeight: semiBold)),
                Text(className,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16, color: whiteColor, fontWeight: semiBold)),
                Text(
                  teachersName,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 12, color: whiteColor, fontWeight: regular),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
