import 'package:isar/isar.dart';

part 'diary.g.dart';

@collection
class Diary {
  int id = Isar.autoIncrement;

  /// 日记唯一标识
  late String diaryId;

  /// 创建时间
  late DateTime createTime;

  /// 日记内容（纯文本）
  late String content;

  /// 情绪值 0.0~1.0
  late double mood;

  /// 情绪名称
  String? moodName;
}
