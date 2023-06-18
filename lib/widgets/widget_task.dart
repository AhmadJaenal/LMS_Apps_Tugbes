import 'package:flutter/material.dart';
import 'package:lms_app_tugbes/shared/theme.dart';

class CardTask extends StatelessWidget {
  final String lessonName;
  final String teachersName;
  final String schedule;
  final String time;
  const CardTask({
    super.key,
    required this.lessonName,
    required this.teachersName,
    required this.schedule,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      height: 137,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: secondaryColor.withOpacity(0.3), width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$lessonName\n$schedule',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: regular, fontSize: 20)),
              const Icon(Icons.arrow_forward_ios_rounded),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(teachersName,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: regular, fontSize: 18)),
              Text(time,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: regular, fontSize: 18)),
            ],
          ),
        ],
      ),
    );
  }
}
