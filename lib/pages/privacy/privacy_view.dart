import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('隐私政策')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('隐私政策', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('更新日期：2026年6月'),
            SizedBox(height: 16),
            Text(
              '心色彩记非常重视您的隐私保护。本隐私政策说明我们如何处理您的信息：',
            ),
            SizedBox(height: 12),
            Text('一、数据收集', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('本应用不收集任何个人身份信息。所有日记数据均存储在您的本地设备中。'),
            SizedBox(height: 12),
            Text('二、数据使用', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('1. 日记内容：仅用于本地展示和分析，不会上传或共享。'),
            Text('2. 情绪数据：仅用于生成情绪趋势图表和AI分析。'),
            Text('3. AI功能：需要您主动配置第三方API，对话内容由第三方服务处理。'),
            SizedBox(height: 12),
            Text('三、数据安全', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('1. 本应用支持密码锁屏功能，保护您的日记隐私。'),
            Text('2. 所有数据存储在本地Isar数据库中，不通过网络传输。'),
            Text('3. API密钥通过SharedPreferences存储在本地。'),
            SizedBox(height: 12),
            Text('四、第三方服务', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('1. DeepSeek大模型：用于AI情绪分析和智能对话。需要您自行注册并配置API密钥。'),
            Text('2. 本应用不内置任何API密钥，所有AI功能的使用均由您主动授权。'),
            SizedBox(height: 12),
            Text('五、数据删除', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('您可以随时在应用内删除任何日记数据。卸载应用将清除所有本地数据。'),
            SizedBox(height: 12),
            Text('六、未成年人保护', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('本应用不针对未成年人，不会主动收集未成年人信息。'),
            SizedBox(height: 12),
            Text('七、联系我们', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('如有隐私相关问题，请通过GitHub仓库提交Issue。'),
          ],
        ),
      ),
    );
  }
}