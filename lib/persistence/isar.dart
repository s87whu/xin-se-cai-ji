import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:moodiary/common/models/diary.dart';

class IsarUtil {
  static late Isar isar;

  static Future<void> initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [DiarySchema],
      directory: dir.path,
    );
  }

  // ========== 写操作 ==========

  /// 新建日记
  static Future<void> addDiary(Diary diary) async {
    await isar.writeTxn(() async {
      await isar.diarys.put(diary);
    });
  }

  /// 更新日记
  static Future<void> updateDiary(Diary diary) async {
    await isar.writeTxn(() async {
      await isar.diarys.put(diary);
    });
  }

  /// 删除日记
  static Future<void> deleteDiary(String diaryId) async {
    await isar.writeTxn(() async {
      final diary = await isar.diarys
          .where()
          .filter()
          .diaryIdEqualTo(diaryId)
          .findFirst();
      if (diary != null) {
        await isar.diarys.delete(diary.id);
      }
    });
  }

  // ========== 读操作 ==========

  /// 获取所有日记（按时间倒序）
  static Future<List<Diary>> getAllDiary() async {
    return await isar.diarys.where().sortByCreateTimeDesc().findAll();
  }

  /// 根据diaryId获取日记
  static Future<Diary?> getDiaryById(String diaryId) async {
    return await isar.diarys
        .where()
        .filter()
        .diaryIdEqualTo(diaryId)
        .findFirst();
  }

  /// 搜索日记（内容包含关键字）
  static Future<List<Diary>> searchDiary(String keyword) async {
    return await isar.diarys
        .where()
        .filter()
        .contentContains(keyword)
        .sortByCreateTimeDesc()
        .findAll();
  }

  /// 获取指定日期范围内的情绪列表
  static Future<List<double>> getMoodByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final diaries = await isar.diarys
        .where()
        .filter()
        .createTimeBetween(start, end)
        .sortByCreateTimeAsc()
        .findAll();
    return diaries.map((d) => d.mood).toList();
  }

  /// 获取指定日期范围内的日期列表
  static Future<List<DateTime>> getDateByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final diaries = await isar.diarys
        .where()
        .filter()
        .createTimeBetween(start, end)
        .sortByCreateTimeAsc()
        .findAll();
    return diaries.map((d) => d.createTime).toList();
  }

  /// 获取指定日期范围内的日记
  static Future<List<Diary>> getDiariesByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    return await isar.diarys
        .where()
        .filter()
        .createTimeBetween(start, end)
        .sortByCreateTimeAsc()
        .findAll();
  }
}
