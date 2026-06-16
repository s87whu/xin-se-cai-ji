import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xin_se_cai_ji/pages/lock/lock_logic.dart';

class LockPage extends StatelessWidget {
  const LockPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(LockLogic());

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              Icon(
                Icons.lock,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text('请输入密码', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(6, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index < logic.inputPassword.value.length
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.shade300,
                        ),
                      );
                    }),
                  )),
              const SizedBox(height: 8),
              Obx(() => logic.isError.value
                  ? Text('密码错误，请重试', style: TextStyle(color: Theme.of(context).colorScheme.error))
                  : const SizedBox()),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Column(
                  children: [
                    _buildRow(logic, ['1', '2', '3']),
                    _buildRow(logic, ['4', '5', '6']),
                    _buildRow(logic, ['7', '8', '9']),
                    _buildRow(logic, ['', '0', '⌫']),
                  ],
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(LockLogic logic, List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: digits.map((d) {
        if (d.isEmpty) return const SizedBox(width: 72, height: 72);
        return SizedBox(
          width: 72,
          height: 72,
          child: TextButton(
            onPressed: () {
              if (d == '⌫') {
                logic.deleteDigit();
              } else {
                logic.addDigit(d);
              }
            },
            style: TextButton.styleFrom(
              shape: const CircleBorder(),
            ),
            child: Text(
              d,
              style: const TextStyle(fontSize: 28),
            ),
          ),
        );
      }).toList(),
    );
  }
}