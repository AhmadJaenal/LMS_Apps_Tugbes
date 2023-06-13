import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/screens/dashboard_page_student.dart';
import 'package:lms_app_tugbes/screens/sign_in_page_student.dart';
import 'package:lms_app_tugbes/screens/sign_up_page_student.dart';
import 'package:lms_app_tugbes/shared/theme.dart';

import 'screens/dashboard_teacher_page.dart';
import 'screens/detail_module_teacher.dart';
import 'screens/list_module_student_page.dart';
import 'screens/list_class_page.dart';
import 'screens/list_module_teacher_page.dart';
import 'screens/sign_in_teacher_page.dart';
import 'screens/sign_up_teacher_page.dart';

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
        '/': (context) => SignInStudent(),
        '/signIn-student': (context) => SignInStudent(),
        '/signIn-teacher': (context) => SignInTeacher(),
        '/signUp-student': (context) => SignUpStudent(),
        '/signUp-teacher': (context) => SignUpTeacher(),
        '/dashboard': (context) => Dashboard(),
        '/dashboard-teacher': (context) => DashboardTeacher(),
        '/list-page': (context) => ListClassPage(),
        '/list-module-student': (context) => ListModuleStudent(),
        '/list-module-teacher': (context) => ListModuleTeacher(),
      },
    );
  }
}
