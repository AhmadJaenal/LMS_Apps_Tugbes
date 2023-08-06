import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lms_app_tugbes/services/query_collection.dart';
import 'package:lms_app_tugbes/shared/theme.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final bool obsecured;
  final String titleTextfield;
  final String hintText;
  final double width;
  const CustomTextfield({
    super.key,
    required this.controller,
    this.obsecured = false,
    required this.hintText,
    required this.titleTextfield,
    this.width = double.infinity,
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
            // inputFormatters: [
            //   LengthLimitingTextInputFormatter(50),
            // ],
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

class TextFieldOnChange extends StatelessWidget {
  final TextEditingController controller;
  final double width;
  final String taskCode;
  final String nis;
  final String fileName;
  const TextFieldOnChange({
    super.key,
    required this.controller,
    this.width = double.infinity,
    required this.taskCode,
    required this.nis,
    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: margin),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            // inputFormatters: [
            //   LengthLimitingTextInputFormatter(2),
            // ],
            // keyboardType: TextInputType.number,
            onChanged: (value) {
              assessment(
                grade: controller.text,
                nis: nis,
                taskCode: taskCode,
                fileName: fileName,
              );
              daftarNilai(
                nis: nis,
                taskCode: taskCode,
                grade: controller.text,
              );
            },
            validator: (value) {
              if (value == "") {
                return "Data tidak boleh kosong";
              }
            },
            controller: controller,
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
            ),
            cursorColor: primaryColor,
          ),
        ],
      ),
    );
  }
}
