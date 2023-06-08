import 'package:flutter/material.dart';
import 'package:lms_app_tugbes/shared/theme.dart';

class CustomButton extends StatelessWidget {
  final String titleButton;
  final Function() onTap;
  const CustomButton(
      {super.key, required this.titleButton, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: margin),
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 24,
              offset: const Offset(12, 12),
              color: primaryColor.withOpacity(.15),
            ),
          ],
        ),
        child: Center(
          child: Text(
            titleButton,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 16, color: whiteColor, fontWeight: regular),
          ),
        ),
      ),
    );
  }
}

class CustomButtonClass extends StatelessWidget {
  final String titleButton;
  final Function() onTap;
  final bool isBig;
  const CustomButtonClass({
    super.key,
    required this.titleButton,
    required this.onTap,
    this.isBig = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isBig ? double.infinity : 140,
        height: isBig ? 48 : 42,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: blueColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: whiteColor,
              ),
              child: Icon(Icons.add, color: blueColor, size: 22, weight: 2),
            ),
            const SizedBox(width: 8),
            Text(
              titleButton,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16, color: whiteColor, fontWeight: semiBold),
            ),
          ],
        ),
      ),
    );
  }
}
