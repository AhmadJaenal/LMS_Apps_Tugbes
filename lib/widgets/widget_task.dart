import 'package:flutter/material.dart';
import 'package:lms_app_tugbes/shared/theme.dart';

class CardTask extends StatelessWidget {
  final String lessonName;
  final String teachersName;
  final String titleTask;
  final String time;
  final Function() ontap;
  const CardTask({
    super.key,
    required this.lessonName,
    required this.teachersName,
    required this.titleTask,
    required this.time,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: margin),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(lessonName,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: bold)),
                const Spacer(),
                Text(teachersName,
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(width: 4),
                Icon(Icons.verified, size: 18, color: blueColor),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Text(titleTask,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.timer_outlined, size: 18, color: secondaryColor),
                const SizedBox(width: 4),
                Text(time, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                color: yellowColor,
                value: .9,
                backgroundColor: secondaryColor.withOpacity(.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
