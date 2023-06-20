import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/shared/theme.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';
import 'package:lms_app_tugbes/widgets/widget_textfield.dart';

class CustomPopUp extends StatelessWidget {
  final TextEditingController controller;
  final String titleButton;
  final String hintText;
  final String titlePopUp;
  final Function() onTap;
  const CustomPopUp(
      {super.key,
      required this.controller,
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
                controller: controller,
                hintText: hintText,
                titleTextfield: '',
              ),
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
  final Function() ontap;
  const CustomPopUpNotif(
      {super.key,
      required this.title,
      required this.desc,
      required this.icon,
      required this.ontap});

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
