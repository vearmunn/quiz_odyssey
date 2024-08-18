import 'package:get/get.dart';
import 'package:quiz_odyssey/services/auth/auth_service.dart';

import '../utils/custom_snackbar.dart';

class AuthController extends GetxController {
  final _auth = AuthService();

  var isLoading = false.obs;

  void loginUser(String email, String password) async {
    isLoading.value = true;
    final res = await _auth.login(email, password);
    res.fold((l) => customSnackbar('Error', l), (r) {});
    isLoading.value = false;
  }

  void registerUser(
      {required String email,
      required String password,
      required String name}) async {
    isLoading.value = true;
    final res =
        await _auth.register(email: email, password: password, name: name);
    res.fold((l) => customSnackbar('Error', l), (r) {});
    isLoading.value = false;
  }

  Future signOut() async {
    try {
      isLoading.value = true;
      await _auth.signOut();
    } catch (e) {
      customSnackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
