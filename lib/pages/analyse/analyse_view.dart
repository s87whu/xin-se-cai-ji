import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xin_se_cai_ji/pages/analyse/analyse_logic.dart';

class AnalysePage extends StatelessWidget {
  const AnalysePage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AnalyseLogic());

    return Scaffold(
      appBar: AppBar(title: const Text('情绪分析')),
      body: Obx(() {
        if (!logic.finished.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (logic.moodList.isEmpty) {
          return const Center(child: Text('该时间段内没有日记记录'));
        }
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 日期范围选择
            Card(
              child: ListTile(
                leading: const Icon(Icons.date_range),
                title: Text(
                  '${logic.dateRange[0].year}/${logic.dateRange[0].month}/${logic.dateRange[0].day} - '
                  '${logic.dateRange[1].year}/${logic.dateRange[1].month}/${logic.dateRange[1].day}',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => logic.openDatePicker(context),
              ),
            ),
            const SizedBox(height: 16),
            // 情绪趋势折线图
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('情绪趋势',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: true),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toStringAsFixed(1),
                                    style: const TextStyle(fontSize: 10),
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                interval:
                                    _calculateInterval(logic.dateList.length),
                                getTitlesWidget: (value, meta) {
                                  final index = value.toInt();
                                  if (index < 0 ||
                                      index >= logic.dateList.length) {
                                    return const SizedBox();
                                  }
                                  final date = logic.dateList[index];
                                  return Text(
                                    '${date.month}/${date.day}',
                                    style: const TextStyle(fontSize: 10),
                                  );
                                },
                              ),
                            ),
                            topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                          ),
                          minY: 0,
                          maxY: 1,
                          lineBarsData: [
                            LineChartBarData(
                              spots: List.generate(
                                logic.moodList.length,
                                (i) => FlSpot(i.toDouble(), logic.moodList[i]),
                              ),
                              isCurved: true,
                              color: Theme.of(context).colorScheme.primary,
                              barWidth: 3,
                              dotData: FlDotData(
                                  show: logic.moodList.length <= 15),
                              belowBarData: BarAreaData(
                                show: true,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withValues(alpha: 0.1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // AI分析按钮
            FilledButton.icon(
              onPressed:
                  logic.isAnalyzing.value ? null : logic.getAiAnalysis,
              icon: logic.isAnalyzing.value
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.auto_awesome),
              label: Text(
                  logic.isAnalyzing.value ? '分析中...' : 'AI分析我的情绪'),
            ),
            const SizedBox(height: 16),
            // AI分析结果
            if (logic.reply.value.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('AI分析',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(logic.reply.value),
                    ],
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }

  double _calculateInterval(int count) {
    if (count <= 7) return 1;
    if (count <= 14) return 2;
    if (count <= 30) return 5;
    return 7;
  }
}
