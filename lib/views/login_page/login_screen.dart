import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contollers/login_controller.dart';

class LoginPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: loginController.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('lib/assets/god.png'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: loginController.emailController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
                validator: loginController.validator,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: loginController.passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: loginController.validator2,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 30),
                child: MaterialButton(
                  minWidth: 350,
                  height: 50,
                  onPressed: loginController.onPressed,
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 60),
                        child: Text(
                          "login",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50),
                        child: Icon(Icons.arrow_forward, color: Colors.white),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
