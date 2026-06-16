import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xin_se_cai_ji/pages/settings/settings_logic.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(SettingsLogic());

    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      body: ListView(
        children: [
          _SectionTitle(title: '外观'),
          Obx(() => ListTile(
                leading: const Icon(Icons.palette),
                title: const Text('主题模式'),
                trailing: DropdownButton<int>(
                  value: logic.themeMode.value,
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(value: 0, child: Text('跟随系统')),
                    DropdownMenuItem(value: 1, child: Text('亮色模式')),
                    DropdownMenuItem(value: 2, child: Text('暗色模式')),
                  ],
                  onChanged: (v) => logic.changeTheme(v!),
                ),
              )),
          const Divider(),
          _SectionTitle(title: '安全'),
          Obx(() => SwitchListTile(
                secondary: const Icon(Icons.lock),
                title: const Text('锁屏密码'),
                subtitle: Text(logic.lockEnabled.value ? '已启用' : '未启用'),
                value: logic.lockEnabled.value,
                onChanged: logic.toggleLock,
              )),
          const Divider(),
          _SectionTitle(title: 'AI功能'),
          ListTile(
            leading: const Icon(Icons.key),
            title: const Text('DeepSeek API配置'),
            subtitle: Obx(() => Text(
                  logic.deepseekApiKey.value.isEmpty ? '未配置' : '已配置',
                  style: TextStyle(
                    color: logic.deepseekApiKey.value.isEmpty ? Colors.red : Colors.green,
                  ),
                )),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showDeepSeekConfigDialog(context, logic),
          ),
          const Divider(),
          _SectionTitle(title: '关于'),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('用户协议'),
            trailing: const Icon(Icons.chevron_right),
            onTap: logic.toAgreement,
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('隐私政策'),
            trailing: const Icon(Icons.chevron_right),
            onTap: logic.toPrivacy,
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text('心色彩记 v1.0.0', style: TextStyle(color: Colors.grey)),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showDeepSeekConfigDialog(BuildContext context, SettingsLogic logic) {
    final apiKeyController = TextEditingController(text: logic.deepseekApiKey.value);

    Get.dialog(
      AlertDialog(
        title: const Text('DeepSeek API配置'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: apiKeyController,
              decoration: const InputDecoration(
                labelText: 'API Key',
                border: OutlineInputBorder(),
                hintText: '输入你的DeepSeek API Key',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('取消')),
          FilledButton(
            onPressed: () {
              logic.saveDeepSeekConfig(
                apiKeyController.text.trim(),
              );
              Get.back();
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}