import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xin_se_cai_ji/api/api.dart';
import 'package:xin_se_cai_ji/common/models/deepseek.dart';
import 'package:xin_se_cai_ji/utils/notice_util.dart';

class AssistantLogic extends GetxController {
  late TextEditingController textController;
  late ScrollController scrollController;

  // 对话消息列表：Map<时间, 消息>
  final messages = <DateTime, _ChatMessage>{}.obs;
  final isGenerating = false.obs;

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController();
    scrollController = ScrollController();
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void clearInput() {
    textController.clear();
  }

  void newChat() {
    messages.clear();
  }

  Future<void> sendMessage() async {
    final text = textController.text.trim();
    if (text.isEmpty) {
      toast.info(message: '请输入问题');
      return;
    }

    final apiKey = Api.checkDeepSeekConfig();
    if (apiKey == null) return;

    clearInput();
    isGenerating.value = true;

    // 添加用户消息
    final askTime = DateTime.now();
    messages[askTime] = _ChatMessage(role: 'user', content: text);

    // 构造请求消息列表
    final deepseekMessages = messages.values
        .map((m) => DeepSeekMessage(role: m.role, content: m.content))
        .toList();

    // 添加空的AI回复占位
    final replyTime = DateTime.now();
    messages[replyTime] = _ChatMessage(role: 'assistant', content: '');

    final stream = await Api.getDeepSeekChat(apiKey, deepseekMessages);

    stream?.listen((content) {
      if (content != '' && content.contains('data')) {
        try {
          final dataPart = content.split('data: ')[1];
          if (dataPart.trim() != '[DONE]') {
            final result = DeepSeekResponse.fromJson(jsonDecode(dataPart));
            if (result.choices != null &&
                result.choices!.isNotEmpty &&
                result.choices!.first.delta != null &&
                result.choices!.first.delta!.content != null) {
              final current = messages[replyTime]!;
              messages[replyTime] = _ChatMessage(
                role: 'assistant',
                content: current.content + result.choices!.first.delta!.content!,
              );
              messages.refresh();
              _scrollToBottom();
            }
          }
        } catch (e) {
          // 忽略解析错误
        }
      }
    }, onDone: () {
      isGenerating.value = false;
    }, onError: (e) {
      isGenerating.value = false;
      toast.error(message: 'AI回复出错');
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }
}

class _ChatMessage {
  final String role;
  final String content;

  _ChatMessage({required this.role, required this.content});
}
