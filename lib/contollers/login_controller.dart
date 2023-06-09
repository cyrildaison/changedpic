// ignore_for_file: prefer_const_constructors

import 'package:app8/views/home_page/home_screen.dart';
import 'package:app8/views/login_page/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> formKey;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Username';
    }
    return null;
  }

  String? validator2(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  Future<void> onPressed() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        if (emailController.text == 'admin' &&
            passwordController.text == 'password') {
          await updateLoginState();
          Get.to(Home());
        } else {
          throw Exception('Invalid username or password');
        }
      } catch (error) {
        showErrorMessage(error.toString());
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> updateLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  void showErrorMessage(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  // ignore: unused_element
  void _checkLoginState(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) =>
            isLoggedIn ? Home() : const LoginPage(),
      ),
    );
  }

  // Main function to demonstrate the login state management
}
