import 'dart:async';

import 'package:xin_se_cai_ji/common/models/deepseek.dart';
import 'package:xin_se_cai_ji/persistence/pref.dart';
import 'package:xin_se_cai_ji/common/values/keys.dart';
import 'package:xin_se_cai_ji/utils/http_util.dart';
import 'package:xin_se_cai_ji/utils/notice_util.dart';

class Api {
  /// DeepSeek对话（流式）
  static Future<Stream<String>?> getDeepSeekChat(
    String apiKey,
    List<DeepSeekMessage> messages, {
    bool showErrorToast = true,
  }) async {
    final body = {
      'model': 'deep-seek-v4-flash',
      'messages': messages.map((m) => m.toJson()).toList(),
      'stream': true,
    };

    final header = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };

    const url = 'https://api.deepseek.com/chat/completions';

    final stream =
        await HttpUtil().postStream(url, header: header, data: body);

    if (stream == null && showErrorToast) {
      toast.error(message: 'AI请求失败，请检查网络和API配置');
    }

    return stream;
  }

  /// 检查DeepSeek API是否已配置
  static String? checkDeepSeekConfig() {
    if (!PrefUtil.containsKey(PrefKeys.deepseekApiKey)) {
      toast.info(message: '请先在设置中配置DeepSeek API Key');
      return null;
    }
    final apiKey = PrefUtil.getValue<String>(PrefKeys.deepseekApiKey);
    if (apiKey.isEmpty) {
      toast.info(message: '请先在设置中配置DeepSeek API Key');
      return null;
    }
    return apiKey;
  }
}
