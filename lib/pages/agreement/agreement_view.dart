import 'package:flutter/material.dart';

class AgreementPage extends StatelessWidget {
  const AgreementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('用户协议')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('用户协议', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('更新日期：2026年6月'),
            SizedBox(height: 16),
            Text(
              '欢迎使用心色彩记（以下简称"本应用"）。在使用本应用之前，请仔细阅读以下协议：',
            ),
            SizedBox(height: 12),
            Text('一、服务内容', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('本应用是一款情绪日记记录工具，提供日记撰写、情绪记录、情绪趋势分析及AI情绪分析等功能。'),
            SizedBox(height: 12),
            Text('二、数据存储', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('1. 您的日记数据仅存储在本地设备中，不会上传至任何服务器。'),
            Text('2. AI功能需要您自行配置第三方API密钥，对话内容将由第三方AI服务处理。'),
            Text('3. 本应用不收集、不存储、不传输任何个人隐私数据。'),
            SizedBox(height: 12),
            Text('三、免责声明', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('1. AI分析结果仅供参考，不构成任何专业建议。'),
            Text('2. 因设备故障、系统更新等原因导致的数据丢失，本应用不承担责任。'),
            Text('3. 建议您定期备份重要数据。'),
            SizedBox(height: 12),
            Text('四、使用规范', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('1. 您应合法合规地使用本应用，不得用于任何违法用途。'),
            Text('2. 您自行配置的API密钥应通过合法途径获取。'),
            SizedBox(height: 12),
            Text('五、协议修改', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('我们保留随时修改本协议的权利，修改后的协议将在应用内公示。'),
          ],
        ),
      ),
    );
  }
}