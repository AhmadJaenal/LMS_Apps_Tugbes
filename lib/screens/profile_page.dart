import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/screens/sign_in_page_student.dart';
import 'package:lms_app_tugbes/services/query_collection.dart';
import 'package:lms_app_tugbes/shared/theme.dart';
import 'package:lms_app_tugbes/widgets/widget_custom_button.dart';

class ProfilePage extends StatelessWidget {
  final String email;
  final bool isTeacher;
  const ProfilePage({super.key, required this.email, this.isTeacher = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: blueColor,
              ),
              child: Icon(Icons.person_outline_rounded,
                  color: whiteColor, size: 24, weight: 3),
            ),
            const SizedBox(height: 32),
            FutureBuilder(
              future: getUser(
                  collection: isTeacher ? 'guru' : 'siswa', email: email),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(
                        snapshot.data!['nama'],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isTeacher
                            ? snapshot.data!['nip']
                            : snapshot.data!['nis'],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            const SizedBox(height: 50),
            CustomButton(
              titleButton: 'Keluar',
              ontap: () {
                Get.off(SignInStudent());
              },
            )
          ],
        ),
      ),
    );
  }
}
