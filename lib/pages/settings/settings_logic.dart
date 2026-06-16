import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xin_se_cai_ji/common/values/keys.dart';
import 'package:xin_se_cai_ji/persistence/pref.dart';
import 'package:xin_se_cai_ji/router/app_routes.dart';
import 'package:xin_se_cai_ji/utils/notice_util.dart';

class SettingsLogic extends GetxController {
  final themeMode = 0.obs;
  final lockEnabled = false.obs;
  final deepseekApiKey = ''.obs;

  @override
  void onInit() {
    super.onInit();
    themeMode.value = PrefUtil.getValue<int>(PrefKeys.themeMode);
    lockEnabled.value = PrefUtil.getValue<bool>(PrefKeys.lock);
    if (PrefUtil.containsKey(PrefKeys.deepseekApiKey)) {
      deepseekApiKey.value = PrefUtil.getValue<String>(PrefKeys.deepseekApiKey);
    }
  }

  Future<void> changeTheme(int index) async {
    themeMode.value = index;
    await PrefUtil.setValue<int>(PrefKeys.themeMode, index);
    Get.changeThemeMode(ThemeMode.values[index]);
  }

  Future<void> toggleLock(bool value) async {
    if (value) {
      final password = await _showPasswordDialog();
      if (password != null && password.isNotEmpty) {
        await PrefUtil.setValue<bool>(PrefKeys.lock, true);
        await PrefUtil.setValue<String>(PrefKeys.password, password);
        lockEnabled.value = true;
        toast.success(message: '锁屏已启用');
      }
    } else {
      await PrefUtil.setValue<bool>(PrefKeys.lock, false);
      lockEnabled.value = false;
      toast.success(message: '锁屏已关闭');
    }
  }

  Future<String?> _showPasswordDialog() async {
    final controller = TextEditingController();
    return Get.dialog<String>(
      AlertDialog(
        title: const Text('设置锁屏密码'),
        content: TextField(
          controller: controller,
          obscureText: true,
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: const InputDecoration(
            hintText: '请输入4-6位数字密码',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: null),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              final pwd = controller.text.trim();
              if (pwd.length < 4) {
                toast.info(message: '密码至少4位');
                return;
              }
              Get.back(result: pwd);
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  Future<void> saveDeepSeekConfig(String apiKey) async {
    await PrefUtil.setValue<String>(PrefKeys.deepseekApiKey, apiKey);
    deepseekApiKey.value = apiKey;
    toast.success(message: 'API配置已保存');
  }

  void toAgreement() => Get.toNamed(AppRoutes.agreementPage);
  void toPrivacy() => Get.toNamed(AppRoutes.privacyPage);
}