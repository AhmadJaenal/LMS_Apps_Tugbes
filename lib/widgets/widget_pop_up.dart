import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms_app_tugbes/shared/theme.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';
import 'package:lms_app_tugbes/widgets/widget_textfield.dart';

class CustomPopUp extends StatelessWidget {
  final bool isTeacher;
  final TextEditingController classNameC;
  final TextEditingController lessonNameC;
  final String titleButton;
  final String hintText;
  final String titlePopUp;
  final Function() onTap;
  const CustomPopUp(
      {super.key,
      this.isTeacher = false,
      required this.classNameC,
      required this.lessonNameC,
      required this.titleButton,
      required this.hintText,
      required this.titlePopUp,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: whiteColor,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.link, color: primaryColor, weight: 24),
                  const SizedBox(width: 8),
                  Text(
                    titlePopUp,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: primaryColor,
                        fontSize: 18,
                        fontWeight: semiBold),
                  )
                ],
              ),
              CustomTextfield(
                controller: classNameC,
                hintText: hintText,
                titleTextfield: '',
              ),
              isTeacher
                  ? CustomTextfield(
                      controller: lessonNameC,
                      hintText: 'Mata Pelajaran',
                      titleTextfield: '',
                    )
                  : const SizedBox(),
              const SizedBox(height: 16),
              CustomButtonClass(
                isBig: true,
                titleButton: titleButton,
                onTap: onTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomPopUpNotif extends StatelessWidget {
  final String title;
  final String desc;
  final String icon;
  final bool isTeacher;
  final String code;
  final Function() ontap;
  const CustomPopUpNotif({
    super.key,
    required this.title,
    required this.desc,
    required this.icon,
    required this.ontap,
    this.isTeacher = false,
    this.code = '',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: whiteColor,
          ),
          child: Column(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                desc,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              isTeacher
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: secondaryColor, width: 2),
                        color: secondaryColor.withOpacity(.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SelectableText(
                        code,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                        enableInteractiveSelection: true,
                        cursorColor: blueColor,
                        cursorWidth: 2.0,
                        showCursor: true,
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(height: 32),
              SvgPicture.asset('assets/$icon'),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    titleButton: 'Go',
                    ontap: ontap,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: SizedBox(
                      width: 100,
                      child: Center(
                        child: Text(
                          'Close',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: secondaryColor, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PopUpLoginRegister extends StatelessWidget {
  final String title;
  final String desc;
  final String icon;
  const PopUpLoginRegister({
    super.key,
    required this.title,
    required this.desc,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: whiteColor,
          ),
          child: Column(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                desc,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: secondaryColor, width: 2),
                  color: secondaryColor.withOpacity(.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 32),
              SvgPicture.asset('assets/$icon'),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );
  }
}

SnackBar customSnackbar({String? message, bool isError = true}) {
  return SnackBar(
    content: Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 50,
            offset: const Offset(10, 10),
            color: secondaryColor.withOpacity(.13),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned(
              bottom: -20,
              left: -20,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isError ? redColor : blueColor,
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: -20,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isError
                      ? redColor.withOpacity(.7)
                      : blueColor.withOpacity(.7),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              right: -30,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isError
                      ? redColor.withOpacity(.7)
                      : blueColor.withOpacity(.7),
                ),
              ),
            ),
            Center(
              child: Text(
                message!,
                style: GoogleFonts.poppins(color: primaryColor, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    ),
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
