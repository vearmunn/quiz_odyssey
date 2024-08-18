// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quiz_odyssey/controllers/auth_controller.dart';
import 'package:quiz_odyssey/controllers/db_controller.dart';
import 'package:quiz_odyssey/theme/colors.dart';
import 'package:quiz_odyssey/utils/spacer.dart';

import '../utils/white_loading.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();
    final dbC = Get.find<DBController>();
    dbC.fetchUserData();
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => dbC.isLoading.value || authC.isLoading.value
              ? whiteCircleLoading()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                          onPressed: () => authC.signOut(),
                          label: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.red),
                          ),
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.red,
                          )),
                    ),
                    verticalSpacer(20),
                    Obx(
                      () => GestureDetector(
                        onTap: () => dbC.uploadAvatar(),
                        child: CircleAvatar(
                          radius: 50,
                          foregroundImage: dbC.userData.value.avatarUrl.isEmpty
                              ? const AssetImage(
                                  "assets/images/default_avatar.jpg")
                              : NetworkImage(dbC.userData.value.avatarUrl),
                        ),
                      ),
                    ),
                    verticalSpacer(30),
                    const Text(
                      "Your Coins",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/coins.png',
                          height: 40,
                        ),
                        horizontalSpacer(4),
                        Text(
                          dbC.userData.value.coins.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 40),
                        ),
                      ],
                    ),
                    verticalSpacer(30),
                    UserInfoTile(
                      label: 'Name',
                      data: dbC.userData.value.name,
                    ),
                    UserInfoTile(
                      label: 'Email',
                      data: dbC.userData.value.email,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class UserInfoTile extends StatelessWidget {
  const UserInfoTile({
    super.key,
    required this.data,
    required this.label,
  });

  final String data;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.grey),
            ),
            Text(
              data,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        verticalSpacer(5),
        Divider(
          color: Colors.grey.shade600,
        ),
        verticalSpacer(15),
      ],
    );
  }
}
