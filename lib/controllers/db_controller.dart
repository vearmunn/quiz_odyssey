import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:quiz_odyssey/models/user.dart';
import 'package:quiz_odyssey/services/db_service.dart';
import 'package:quiz_odyssey/utils/custom_snackbar.dart';

class DBController extends GetxController {
  final _db = DBService();
  final _firebaseStorage = FirebaseStorage.instance;

  var isLoading = false.obs;
  var coins = 0.obs;

  var allUsers = <User>[].obs;
  var userData =
      User(uid: "", name: "", email: "", avatarUrl: "", coins: 0).obs;

  Future saveQuizRecord(String difficulty) async {
    // calculate how much coins earned based on difficulty
    try {
      if (difficulty == "easy") {
        coins.value = coins.value * 30;
      } else if (difficulty == 'medium') {
        coins.value = coins.value * 40;
      } else {
        coins.value = coins.value * 50;
      }
      print("Coins${coins.value}");
      isLoading.value = true;

      // sum coins earned after finishing a quiz with current user's coins
      await _db.saveQuizRecord(coins.value + userData.value.coins);
    } catch (e) {
      customSnackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future fetchAllUsers() async {
    try {
      isLoading.value = true;
      final res = await _db.fetchAllUsers();
      allUsers.value = res;
      print(allUsers);
    } catch (e) {
      customSnackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future fetchUserData() async {
    try {
      isLoading.value = true;
      final res = await _db.fetchUserData();
      userData.value = res;
    } catch (e) {
      customSnackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future uploadAvatar() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    File file = File(image.path);

    try {
      // define the path in storage
      String filePath = "user_avatar/${userData.value.uid}";

      // Upload the file to firebase storage
      await _firebaseStorage.ref(filePath).putFile(file);

      // after uploading, fetch the download url
      String downloadUrl =
          await _firebaseStorage.ref(filePath).getDownloadURL();

      await _db.uploadAvatar(downloadUrl);

      await fetchUserData();
    } catch (e) {
      customSnackbar("Error", e.toString());
    }
  }
}
