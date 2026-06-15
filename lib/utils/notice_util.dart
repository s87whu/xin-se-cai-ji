import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Toast提示工具
class NoticeUtil {
  void info({required String message}) {
    Get.snackbar(
      '提示',
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    );
  }

  void success({required String message}) {
    Get.snackbar(
      '成功',
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      backgroundColor: Colors.green.withOpacity(0.1),
      duration: const Duration(seconds: 2),
    );
  }

  void error({required String message}) {
    Get.snackbar(
      '错误',
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      backgroundColor: Colors.red.withOpacity(0.1),
      duration: const Duration(seconds: 3),
    );
  }
}

final toast = NoticeUtil();
