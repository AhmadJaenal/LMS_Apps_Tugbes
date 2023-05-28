import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lms_app_tugbes/shared/theme.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: margin),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 42),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome back',
                            style: Theme.of(context).textTheme.bodySmall),
                        Text('Jonua',
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: blueColor,
                      ),
                      child: Icon(Icons.person_outline_rounded,
                          color: whiteColor, size: 14, weight: 3),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              CustomButtonClass(
                onTap: () {},
                titleButton: 'Join Class',
              ),
              const SizedBox(height: 24),
              Text('Your Class', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  child: Row(
                    children: [
                      CardClass(
                        className: '12 IPA b',
                        lessonName: 'Math',
                        color: blueColor,
                        teachersName: 'Yati S.Pd',
                        theNumberOfStudent: 32,
                        pattern: 'pattern_math.svg',
                      ),
                      const SizedBox(width: 16),
                      CardClass(
                        className: '12 IPA b',
                        lessonName: 'Sosial',
                        color: redColor,
                        teachersName: 'Iwan S.Pd',
                        theNumberOfStudent: 20,
                        pattern: 'pattern_sosial.svg',
                      ),
                      const SizedBox(width: 16),
                      CardClass(
                        className: '12 IPA b',
                        lessonName: 'English',
                        color: yellowColor,
                        teachersName: 'Wida S.Pd',
                        theNumberOfStudent: 25,
                        pattern: 'pattern_sosial.svg',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Task', style: Theme.of(context).textTheme.titleLarge),
                  Text(
                    'View all',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: primaryColor),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const CardTask(
                lessonName: 'Math',
                schedule: 'Modul 5',
                teachersName: 'Yati S.Pd',
                time: '09:00-11:00',
              ),
              const SizedBox(height: 16),
              const CardTask(
                lessonName: 'Math',
                schedule: 'Modul 5',
                teachersName: 'Yati S.Pd',
                time: '09:00-11:00',
              ),
              const SizedBox(height: 16),
              const CardTask(
                lessonName: 'Math',
                schedule: 'Modul 5',
                teachersName: 'Yati S.Pd',
                time: '09:00-11:00',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

class CardClass extends StatelessWidget {
  final String lessonName;
  final String className;
  final String teachersName;
  final String pattern;
  final int theNumberOfStudent;
  final Color color;
  const CardClass({
    super.key,
    required this.lessonName,
    required this.className,
    required this.teachersName,
    this.pattern = '',
    required this.theNumberOfStudent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
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
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
    );
  }
}
