import 'package:flutter/material.dart';
import 'package:get/get.dart';

void customSnackbar(String title, String message,
    {Color background = Colors.red}) {
  Get.snackbar(
    title,
    message,
    backgroundColor: background,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(15),
  );
}
