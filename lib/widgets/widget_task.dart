import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_app_tugbes/services/date.dart';
import 'package:lms_app_tugbes/shared/theme.dart';

class CardTask extends StatelessWidget {
  final String dsc;
  final String timeLine;
  final String fileName;
  final Function() ontap;
  const CardTask({
    super.key,
    required this.fileName,
    required this.dsc,
    required this.timeLine,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    TimeRemaining timeRemaining = TimeRemaining();
    String countdown = timeRemaining.calculateCountdown(timeLine);
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.only(left: margin, right: margin, top: 8),
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
            Text(
              dsc,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                SvgPicture.asset('assets/pdf.svg', width: 24),
                const SizedBox(width: 8),
                SizedBox(
                  width: 250,
                  child: Text(
                    fileName,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.timer_outlined, size: 18, color: secondaryColor),
                const SizedBox(width: 4),
                Text(timeLine, style: Theme.of(context).textTheme.bodySmall),
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
