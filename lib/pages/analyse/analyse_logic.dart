import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xin_se_cai_ji/api/api.dart';
import 'package:xin_se_cai_ji/common/models/deepseek.dart';
import 'package:xin_se_cai_ji/persistence/isar.dart';
import 'package:xin_se_cai_ji/utils/notice_util.dart';

class AnalyseLogic extends GetxController {
  final dateRange = <DateTime>[
    DateTime.now().subtract(const Duration(days: 30)),
    DateTime.now(),
  ].obs;

  final moodList = <double>[].obs;
  final dateList = <DateTime>[].obs;
  final finished = false.obs;
  final reply = ''.obs;
  final isAnalyzing = false.obs;

  @override
  void onReady() {
    loadData();
    super.onReady();
  }

  Future<void> loadData() async {
    finished.value = false;
    moodList.value = await IsarUtil.getMoodByDateRange(
      dateRange[0],
      dateRange[1].add(const Duration(days: 1)),
    );
    dateList.value = await IsarUtil.getDateByDateRange(
      dateRange[0],
      dateRange[1].add(const Duration(days: 1)),
    );
    finished.value = true;
  }

  Future<void> openDatePicker(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(
        start: dateRange[0],
        end: dateRange[1],
      ),
    );
    if (picked != null) {
      dateRange.value = [picked.start, picked.end];
      await loadData();
    }
  }

  Future<void> getAiAnalysis() async {
    final apiKey = Api.checkDeepSeekConfig();
    if (apiKey == null) return;

    isAnalyzing.value = true;
    reply.value = '';

    // 统计情绪分布
    final moodMap = <String, int>{};
    for (final mood in moodList) {
      final key = mood.toStringAsFixed(1);
      moodMap[key] = (moodMap[key] ?? 0) + 1;
    }

    final stream = await Api.getDeepSeekChat(
      apiKey,
      [
        DeepSeekMessage(
          role: 'system',
          content: '我会给你一组来自一款日记APP的数据，其中包含了在某一段时间内，'
              '日记所记录的心情情况，根据这些数据，分析用户最近的心情状况，并给出合理的建议。'
              '心情的值是一个从0.0到1.0的浮点数，从小到大表示心情从坏到好。'
              '给你的值是一个Map，其中的Key是心情指数，Value是对应心情指数出现的次数。'
              '给出的输出应当是结论，不需要给出分析过程，不需要其他反馈。',
        ),
        DeepSeekMessage(
          role: 'user',
          content: '心情：${moodMap.toString()}',
        ),
      ],
    );

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
              reply.value += result.choices!.first.delta!.content!;
            }
          }
        } catch (e) {
          // 忽略解析错误
        }
      }
    }, onDone: () {
      isAnalyzing.value = false;
    }, onError: (e) {
      isAnalyzing.value = false;
      toast.error(message: 'AI分析出错');
    });
  }
}
