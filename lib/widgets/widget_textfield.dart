import 'package:flutter/material.dart';
import 'package:lms_app_tugbes/shared/theme.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final bool obsecured;
  final String titleTextfield;
  final String hintText;
  const CustomTextfield(
      {super.key,
      required this.controller,
      this.obsecured = false,
      required this.hintText,
      required this.titleTextfield});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: margin),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleTextfield,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: primaryColor,
                  fontWeight: medium,
                ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            validator: (value) {
              if (value == "") {
                return "input data correctly";
              }
            },
            controller: controller,
            obscureText: obsecured,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: secondaryColor.withOpacity(.2), width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: redColor.withOpacity(.7), width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: secondaryColor.withOpacity(.4), width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: blueColor, width: 2.0),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                hintText: hintText),
            cursorColor: primaryColor,
          ),
        ],
      ),
    );
  }
}
