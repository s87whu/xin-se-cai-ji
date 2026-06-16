import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moodiary/common/values/colors.dart';
import 'package:moodiary/pages/home/home_logic.dart';
import 'package:moodiary/router/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic());

    return Scaffold(
      appBar: AppBar(
        title: const Text('心色彩记'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearch(context, logic),
          ),
        ],
      ),
      body: Obx(() {
        final list = logic.isSearching.value
            ? logic.searchResults
            : logic.diaryList;
        if (list.isEmpty) {
          return const Center(child: Text('还没有日记，点击＋开始记录'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final diary = list[index];
            return _DiaryCard(diary: diary, logic: logic);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => logic.toEditor(),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: _BottomNav(),
    );
  }

  void _showSearch(BuildContext context, HomeLogic logic) {
    showSearch(
      context: context,
      delegate: _DiarySearchDelegate(logic),
    );
  }
}

class _DiaryCard extends StatelessWidget {
  final Diary diary;
  final HomeLogic logic;

  const _DiaryCard({required this.diary, required this.logic});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: MoodColors.getColor(diary.mood),
          child: Text(
            MoodColors.moods.firstWhere(
              (m) => m['name'] == diary.moodName,
              orElse: () => MoodColors.moods[2],
            )['icon'],
          ),
        ),
        title: Text(
          diary.content.length > 50
              ? '${diary.content.substring(0, 50)}...'
              : diary.content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${diary.createTime.year}-${diary.createTime.month.toString().padLeft(2, '0')}-${diary.createTime.day.toString().padLeft(2, '0')} ${diary.moodName ?? ''}',
        ),
        onTap: () => logic.toEditor(diary: diary),
        onLongPress: () => _confirmDelete(context, logic),
      ),
    );
  }

  void _confirmDelete(BuildContext context, HomeLogic logic) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('确认删除'),
        content: const Text('删除后无法恢复，确定要删除这篇日记吗？'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          TextButton(
            onPressed: () {
              logic.deleteDiary(diary.diaryId);
              Navigator.pop(ctx);
            },
            child: const Text('删除', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: 0,
      onDestinationSelected: (index) {
        switch (index) {
          case 0:
            break;
          case 1:
            Get.toNamed(AppRoutes.analysePage);
            break;
          case 2:
            Get.toNamed(AppRoutes.assistantPage);
            break;
          case 3:
            Get.toNamed(AppRoutes.settingsPage);
            break;
        }
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: '首页'),
        NavigationDestination(icon: Icon(Icons.analytics), label: '分析'),
        NavigationDestination(icon: Icon(Icons.smart_toy), label: '助手'),
        NavigationDestination(icon: Icon(Icons.settings), label: '设置'),
      ],
    );
  }
}

class _DiarySearchDelegate extends SearchDelegate {
  final HomeLogic logic;

  _DiarySearchDelegate(this.logic);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    logic.searchDiary(query);
    return Obx(() => ListView.builder(
      itemCount: logic.searchResults.length,
      itemBuilder: (context, index) {
        final diary = logic.searchResults[index];
        return ListTile(
          title: Text(diary.content, maxLines: 2, overflow: TextOverflow.ellipsis),
          subtitle: Text(diary.moodName ?? ''),
          onTap: () {
            close(context, null);
            logic.toEditor(diary: diary);
          },
        );
      },
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text('输入关键词搜索日记'));
  }
}
