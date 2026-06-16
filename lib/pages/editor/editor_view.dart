import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moodiary/common/values/colors.dart';
import 'package:moodiary/pages/editor/editor_logic.dart';

class EditorPage extends StatelessWidget {
  const EditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(EditorLogic());

    return Scaffold(
      appBar: AppBar(
        title: Text(logic.editDiaryId != null ? '编辑日记' : '新建日记'),
        actions: [
          TextButton(
            onPressed: logic.saveDiary,
            child: const Text('保存', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 日期显示
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${logic.createTime.year}-${logic.createTime.month.toString().padLeft(2, '0')}-${logic.createTime.day.toString().padLeft(2, '0')}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 情绪选择
            GetBuilder<EditorLogic>(
              builder: (_) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('心情', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: MoodColors.moods.map((mood) {
                      final isSelected = logic.selectedMood == mood['value'];
                      return ChoiceChip(
                        label: Text('${mood['icon']} ${mood['name']}'),
                        selected: isSelected,
                        selectedColor: (mood['color'] as Color).withOpacity(0.3),
                        onSelected: (_) => logic.selectMood(
                          mood['value'],
                          mood['name'],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // 内容输入
            Expanded(
              child: TextField(
                controller: logic.contentController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  hintText: '今天有什么想记录的？',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
