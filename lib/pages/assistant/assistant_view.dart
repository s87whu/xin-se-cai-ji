import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xin_se_cai_ji/pages/assistant/assistant_logic.dart';

class AssistantPage extends StatelessWidget {
  const AssistantPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AssistantLogic());

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI助手'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => logic.newChat(),
            tooltip: '清空对话',
          ),
        ],
      ),
      body: Column(
        children: [
          // 消息列表
          Expanded(
            child: Obx(() {
              if (logic.messages.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.smart_toy, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('和AI助手聊聊吧', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                );
              }
              return ListView.builder(
                controller: logic.scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: logic.messages.length,
                itemBuilder: (context, index) {
                  final entry = logic.messages.entries.elementAt(index);
                  final msg = entry.value;
                  final isUser = msg.role == 'user';
                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      decoration: BoxDecoration(
                        color: isUser
                            ? Theme.of(context).colorScheme.primaryContainer
                            : Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(msg.content),
                    ),
                  );
                },
              );
            }),
          ),
          // 输入区域
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: logic.textController,
                    decoration: const InputDecoration(
                      hintText: '输入问题...',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    onSubmitted: (_) => logic.sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                Obx(() => IconButton.filled(
                      onPressed:
                          logic.isGenerating.value ? null : logic.sendMessage,
                      icon: logic.isGenerating.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.send),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
