import 'package:flutter/material.dart';

/// 6色情绪盘
class MoodColors {
  static const List<Map<String, dynamic>> moods = [
    {'name': '开心', 'value': 1.0, 'color': Color(0xFFFFD700), 'icon': '😊'},
    {'name': '平静', 'value': 0.8, 'color': Color(0xFF90EE90), 'icon': '😌'},
    {'name': '一般', 'value': 0.6, 'color': Color(0xFF87CEEB), 'icon': '😐'},
    {'name': '焦虑', 'value': 0.4, 'color': Color(0xFFFFA500), 'icon': '😰'},
    {'name': '难过', 'value': 0.2, 'color': Color(0xFF6495ED), 'icon': '😢'},
    {'name': '愤怒', 'value': 0.0, 'color': Color(0xFFFF6347), 'icon': '😡'},
  ];

  /// 根据情绪值获取颜色
  static Color getColor(double mood) {
    if (mood >= 0.9) return moods[0]['color'];
    if (mood >= 0.7) return moods[1]['color'];
    if (mood >= 0.5) return moods[2]['color'];
    if (mood >= 0.3) return moods[3]['color'];
    if (mood >= 0.1) return moods[4]['color'];
    return moods[5]['color'];
  }

  /// 根据情绪值获取名称
  static String getName(double mood) {
    if (mood >= 0.9) return moods[0]['name'];
    if (mood >= 0.7) return moods[1]['name'];
    if (mood >= 0.5) return moods[2]['name'];
    if (mood >= 0.3) return moods[3]['name'];
    if (mood >= 0.1) return moods[4]['name'];
    return moods[5]['name'];
  }
}
