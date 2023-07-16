import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/screens/dashboard.dart';
import 'package:lms_app_tugbes/screens/list_class_page.dart';
import 'package:lms_app_tugbes/screens/profile_page.dart';
import 'package:lms_app_tugbes/widgets/widget_pop_up.dart';

import '../widgets/widget_nav_bar.dart';

class AuthServices {
  static Future signUp({
    String? email,
    password,
    validate,
    collection,
    bool isTeacher = false,
  }) async {
    try {
      if (password == validate) {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email!,
          password: password,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          customSnackbar(message: "Sign Up Success", isError: false),
        );
        Get.off(NavBarMenu(
          pageOption: [
            Dashboard(
              email: email,
              collection: collection,
              isTeacher: isTeacher,
            ),
            ListClassPage(email: email, collection: collection),
            ProfilePage(email: email),
          ],
        ));
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          customSnackbar(message: "Password tidak sama"),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'invalid-email') {
        errorMessage = 'Format email tidak sesuai';
      }
      if (e.code == 'weak-password') {
        errorMessage = 'Password harus memiliki setidaknya 8 character';
      }
      if (e.code == 'email-already-in-use') {
        errorMessage = 'Email ini sudah tersedia';
      }
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        customSnackbar(message: e.toString()),
      );
    } catch (e) {
      return null;
    }
  }

  static Future signIn(
      {String? email, password, collection, bool isTeacher = false}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password,
      );
      Get.off(NavBarMenu(
        pageOption: [
          Dashboard(
            email: email,
            collection: collection,
            isTeacher: isTeacher,
          ),
          ListClassPage(email: email, collection: collection),
          ProfilePage(email: email),
        ],
      ));
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        customSnackbar(message: "Sign In Success", isError: false),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = e.code;
      if (e.code == 'invalid-email') {
        errorMessage = 'Format email tidak sesuai';
      }
      if (e.code == 'wrong-password') {
        errorMessage = 'Password salah';
      }
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        customSnackbar(message: errorMessage),
      );
    } catch (e) {
      return null;
    }
  }
}
