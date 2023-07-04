import 'package:dotted_border/dotted_border.dart';
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

class ButtonUploadFile extends StatelessWidget {
  final String selectedFileName;
  const ButtonUploadFile({super.key, this.selectedFileName = 'Upload File'});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: const [5, 6],
      strokeCap: StrokeCap.round,
      color: secondaryColor.withOpacity(.4),
      strokeWidth: 2,
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        width: double.infinity,
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  selectedFileName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16,
                        color: secondaryColor,
                        fontWeight: semiBold,
                      ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.add, color: secondaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
