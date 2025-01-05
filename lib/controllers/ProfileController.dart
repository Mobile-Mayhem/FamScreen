import 'package:famscreen/routes/AppRoutes.dart';
import 'package:get/get.dart';

import 'AuthController.dart';

class ProfileController extends GetxController {
  final _authController = Get.put(AuthController());

  RxString userName = ''.obs;
  RxString userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();

    _loadUserData();
  }

  void _loadUserData() {
    final user = _authController.getCurrentUser();
    userName.value = user?.displayName ?? 'Belum diisi';
    userEmail.value = user?.email ?? 'login guest';
  }

  Future<void> logout() async {
    try {
      await _authController.signout(Get.context!);

      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar('Logout Gagal', 'Terjadi kesalahan saat logout: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
