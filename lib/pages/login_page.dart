// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_odyssey/controllers/auth_controller.dart';
import 'package:quiz_odyssey/theme/colors.dart';

import 'package:quiz_odyssey/utils/spacer.dart';
import 'package:quiz_odyssey/utils/white_loading.dart';
import 'package:quiz_odyssey/widgets/auth_textfield.dart';
import 'package:quiz_odyssey/widgets/my_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          children: [
            const Center(
              child: Text(
                "Welcome to Quiz Odyssey!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            verticalSpacer(30),
            AuthTextField(
              hintText: 'Email',
              controller: emailController,
              textInputType: TextInputType.emailAddress,
            ),
            verticalSpacer(16),
            AuthTextField(
              hintText: 'Password',
              controller: passwordController,
              obscureText: true,
            ),
            verticalSpacer(30),
            Obx(
              () => authC.isLoading.value
                  ? whiteCircleLoading()
                  : MyButton(
                      text: 'LOGIN',
                      onTap: () {
                        authC.loginUser(
                            emailController.text, passwordController.text);
                      }),
            ),
            verticalSpacer(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.white),
                ),
                GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Register",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
