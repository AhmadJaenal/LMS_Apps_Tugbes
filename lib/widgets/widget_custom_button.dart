import 'package:flutter/material.dart';
import 'package:lms_app_tugbes/shared/theme.dart';

class CustomButton extends StatelessWidget {
  final String titleButton;
  final Function() ontap;
  final double width;
  const CustomButton({
    super.key,
    required this.titleButton,
    required this.ontap,
    this.width = 100,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap,
      style: ElevatedButton.styleFrom(
          foregroundColor: blueColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: primaryColor,
          minimumSize: Size(width, 48)),
      child: Text(
        titleButton,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontSize: 16, color: whiteColor, fontWeight: semiBold),
      ),
    );
  }
}

class CustomButtonClass extends StatelessWidget {
  final String titleButton;
  final Function() onTap;
  final bool isBig;

  const CustomButtonClass(
      {super.key,
      required this.titleButton,
      required this.onTap,
      this.isBig = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(Icons.add_circle_outline_sharp, color: whiteColor),
      label: Text(
        titleButton,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontSize: 16, color: whiteColor, fontWeight: semiBold),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: primaryColor,
        minimumSize:
            isBig ? const Size(double.infinity, 42) : const Size(70, 42),
        backgroundColor: blueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
