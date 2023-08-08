import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lms_app_tugbes/shared/theme.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final bool obsecured;
  final String titleTextfield;
  final String hintText;
  final double width;
  final bool isNumber;
  final bool isAssesment;
  const CustomTextfield({
    super.key,
    required this.controller,
    this.obsecured = false,
    required this.hintText,
    required this.titleTextfield,
    this.width = double.infinity,
    this.isNumber = false,
    this.isAssesment = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: margin),
      width: width,
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
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            inputFormatters: [
              LengthLimitingTextInputFormatter(isAssesment ? 4 : 50),
            ],
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
