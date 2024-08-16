// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../utils/spacer.dart';
import '../widgets/auth_textfield.dart';
import '../widgets/my_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final AuthController authC = Get.find<AuthController>();
    final key = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController cpasswordController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Form(
          key: key,
          child: ListView(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            children: [
              verticalSpacer(20),
              const Text(
                "Let's Create Your Account!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              verticalSpacer(30),
              AuthTextField(
                controller: nameController,
                hintText: 'Name',
                textInputType: TextInputType.name,
              ),
              verticalSpacer(20),
              AuthTextField(
                controller: emailController,
                hintText: 'Email',
                textInputType: TextInputType.emailAddress,
              ),
              verticalSpacer(20),
              AuthTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              verticalSpacer(20),
              AuthTextField(
                controller: cpasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),
              verticalSpacer(20),
              Obx(
                () => authC.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : MyButton(
                        text: 'REGISTER',
                        onTap: () {
                          if (key.currentState!.validate() &&
                              passwordController.text ==
                                  cpasswordController.text) {
                            authC.registerUser(
                                emailController.text, passwordController.text);
                          } else if (passwordController.text !=
                              cpasswordController.text) {
                            Get.snackbar('Warning!', "Password doesn't match!");
                          }
                        }),
              ),
              verticalSpacer(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        " Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
