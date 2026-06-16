import 'package:get/get.dart';
import 'package:xin_se_cai_ji/persistence/pref.dart';
import 'package:xin_se_cai_ji/common/values/keys.dart';
import 'package:xin_se_cai_ji/router/app_routes.dart';

class LockLogic extends GetxController {
  final inputPassword = ''.obs;
  final isError = false.obs;

  void addDigit(String digit) {
    if (inputPassword.value.length >= 6) return;
    inputPassword.value += digit;
    if (inputPassword.value.length >= 4) {
      _checkPassword();
    }
  }

  void deleteDigit() {
    if (inputPassword.value.isEmpty) return;
    inputPassword.value = inputPassword.value.substring(0, inputPassword.value.length - 1);
    isError.value = false;
  }

  void _checkPassword() {
    final savedPassword = PrefUtil.getValue<String>(PrefKeys.password);
    if (inputPassword.value == savedPassword) {
      Get.offAllNamed(AppRoutes.homePage);
    } else {
      isError.value = true;
      inputPassword.value = '';
    }
  }
}