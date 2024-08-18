import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_odyssey/controllers/db_controller.dart';
import 'package:quiz_odyssey/pages/primary_page.dart';
import 'package:quiz_odyssey/services/auth/login_or_register.dart';

import '../../controllers/api_controller.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final apiController = Get.put(ApiController());
    apiController.fetchAllCategories();
    Get.put(DBController());
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return const PrimaryPage();
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
