import 'dart:async';
import 'package:app8/views/home_page/home_screen.dart';
import 'package:app8/views/login_page/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      _checkLoginState(context);
    });

    return const Scaffold(
      body: Center(
        child: CircleAvatar(
          radius: 80,
          backgroundImage: AssetImage('lib/assets/god.png'),
        ),
      ),
    );
  }

  void _checkLoginState(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) =>
            isLoggedIn ? const Home() : const LoginPage(),
      ),
    );
  }
}
