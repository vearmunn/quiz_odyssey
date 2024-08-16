import 'package:get/get.dart';
import 'package:quiz_odyssey/services/auth/auth_service.dart';

class AuthController extends GetxController {
  final _auth = AuthService();

  var isLoading = false.obs;

  void loginUser(String email, String password) async {
    isLoading.value = true;
    final res = await _auth.login(email, password);
    res.fold((l) => Get.snackbar('Error', l), (r) {});
    isLoading.value = false;
  }

  void registerUser(String email, String password) async {
    isLoading.value = true;
    final res = await _auth.register(email, password);
    res.fold((l) => Get.snackbar('Error', l), (r) {});
    isLoading.value = false;
  }

  Future signOut() async {
    try {
      isLoading.value = true;
      await _auth.signOut();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
