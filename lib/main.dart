import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/screens/sign_in_page_student.dart';
import 'package:lms_app_tugbes/screens/sign_up_page_student.dart';
import 'package:lms_app_tugbes/shared/theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'screens/sign_in_teacher_page.dart';
import 'screens/sign_up_teacher_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  //
  await Firebase.initializeApp();
  runApp(const MyApp());
  FlutterNativeSplash.remove();
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
        '/': (context) => const SignInStudent(),
        '/signIn-student': (context) => const SignInStudent(),
        '/signIn-teacher': (context) => SignInTeacher(),
        '/signUp-student': (context) => SignUpStudent(),
        '/signUp-teacher': (context) => SignUpTeacher(),
      },
    );
  }
}
