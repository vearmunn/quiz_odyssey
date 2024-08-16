import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_odyssey/controllers/auth_controller.dart';
import 'package:quiz_odyssey/widgets/my_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => authC.isLoading.value
                ? const CircularProgressIndicator()
                : MyButton(
                    onTap: () {
                      authC.signOut();
                    },
                    text: 'Sign Out',
                  ),
          ),
        ],
      ),
    );
  }
}
