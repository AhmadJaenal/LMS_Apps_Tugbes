import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/screens/dashboard_page_student.dart';
import 'package:lms_app_tugbes/screens/login_page_student.dart';
import 'package:lms_app_tugbes/screens/register_page_student.dart';
import 'package:lms_app_tugbes/shared/theme.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: primaryColor,
        scaffoldBackgroundColor: whiteColor,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 24.0,
            fontWeight: semiBold,
          ),
          bodyLarge: TextStyle(
            fontSize: 22.0,
            fontWeight: semiBold,
          ),
          bodyMedium: TextStyle(
            fontSize: 18.0,
            fontWeight: regular,
          ),
          bodySmall: TextStyle(
            fontSize: 14.0,
            fontWeight: medium,
          ),
        ),
      ),
      routes: {
        '/': (context) => LoginPageStudent(),
        '/register-student': (context) => RegisterPageStudent(),
        '/dashboard': (context) => Dashboard(),
      },
    );
  }
}
