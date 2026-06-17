import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xin_se_cai_ji/common/models/diary.dart';

class IsarUtil {
  static late Isar isar;

  static Future<void> initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      schemas: [DiarySchema],
      directory: dir.path,
    );
  }

  // ========== 写操作 ==========

  /// 新建日记
  static void addDiary(Diary diary) {
    diary.id = isar.diarys.autoIncrement();
    isar.diarys.put(diary);
  }

  /// 更新日记
  static void updateDiary(Diary diary) {
    isar.diarys.put(diary);
  }

  /// 删除日记
  static void deleteDiary(String diaryId) {
    final diary =
        isar.diarys.where().diaryIdEqualTo(diaryId).build().findFirst();
    if (diary != null) {
      isar.diarys.delete(diary.id);
    }
  }

  // ========== 读操作 ==========

  /// 获取所有日记（按时间倒序）
  static List<Diary> getAllDiary() {
    return isar.diarys.where().sortByCreateTimeDesc().build().findAll();
  }

  /// 根据diaryId获取日记
  static Diary? getDiaryById(String diaryId) {
    return isar.diarys.where().diaryIdEqualTo(diaryId).build().findFirst();
  }

  /// 搜索日记（内容包含关键字）
  static List<Diary> searchDiary(String keyword) {
    return isar.diarys
        .where()
        .contentContains(keyword)
        .sortByCreateTimeDesc()
        .build()
        .findAll();
  }

  /// 获取指定日期范围内的情绪列表
  static List<double> getMoodByDateRange(
    DateTime start,
    DateTime end,
  ) {
    final diaries = isar.diarys
        .where()
        .createTimeBetween(start, end)
        .sortByCreateTime()
        .build()
        .findAll();
    return diaries.map((d) => d.mood).toList();
  }

  /// 获取指定日期范围内的日期列表
  static List<DateTime> getDateByDateRange(
    DateTime start,
    DateTime end,
  ) {
    final diaries = isar.diarys
        .where()
        .createTimeBetween(start, end)
        .sortByCreateTime()
        .build()
        .findAll();
    return diaries.map((d) => d.createTime).toList();
  }

  /// 获取指定日期范围内的日记
  static List<Diary> getDiariesByDateRange(
    DateTime start,
    DateTime end,
  ) {
    return isar.diarys
        .where()
        .createTimeBetween(start, end)
        .sortByCreateTime()
        .build()
        .findAll();
  }
}
