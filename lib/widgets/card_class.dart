import 'package:flutter/material.dart';
import 'package:lms_app_tugbes/shared/theme.dart';

class CardClass extends StatelessWidget {
  final String lessonName;
  final String className;
  final int theNumberOfStudent;
  final Function() onTap;
  const CardClass({
    super.key,
    required this.lessonName,
    required this.className,
    required this.theNumberOfStudent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 300,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(className,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: bold)),
                const Spacer(),
                const SizedBox(width: 4),
                Icon(Icons.verified, size: 18, color: blueColor),
              ],
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(lessonName,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: bold),
                  overflow: TextOverflow.ellipsis),
            ),
            const Spacer(),
            Row(
              children: [
                Icon(Icons.person_2_rounded, size: 18, color: blueColor),
                const SizedBox(width: 4),
                Text(
                  '$theNumberOfStudent Student',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: secondaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
