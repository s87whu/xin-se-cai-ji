import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:moodiary/common/models/diary.dart';
import 'package:moodiary/common/values/colors.dart';
import 'package:moodiary/persistence/isar.dart';
import 'package:moodiary/utils/notice_util.dart';

class EditorLogic extends GetxController {
  late TextEditingController contentController;
  late double selectedMood;
  late String selectedMoodName;
  late DateTime createTime;
  late String? editDiaryId; // 编辑时传入的日记ID

  @override
  void onInit() {
    super.onInit();
    contentController = TextEditingController();
    selectedMood = 0.6;
    selectedMoodName = '一般';
    createTime = DateTime.now();
    editDiaryId = null;

    // 如果是编辑模式，加载已有数据
    final args = Get.arguments;
    if (args is Diary) {
      editDiaryId = args.diaryId;
      contentController.text = args.content;
      selectedMood = args.mood;
      selectedMoodName = args.moodName ?? '一般';
      createTime = args.createTime;
    }
  }

  void selectMood(double value, String name) {
    selectedMood = value;
    selectedMoodName = name;
    update();
  }

  Future<void> saveDiary() async {
    final content = contentController.text.trim();
    if (content.isEmpty) {
      toast.info(message: '请输入日记内容');
      return;
    }

    final diary = Diary()
      ..diaryId = editDiaryId ?? const Uuid().v4()
      ..content = content
      ..mood = selectedMood
      ..moodName = selectedMoodName
      ..createTime = createTime;

    if (editDiaryId != null) {
      await IsarUtil.updateDiary(diary);
    } else {
      await IsarUtil.addDiary(diary);
    }

    toast.success(message: '保存成功');
    Get.back();
  }

  @override
  void onClose() {
    contentController.dispose();
    super.onClose();
  }
}
