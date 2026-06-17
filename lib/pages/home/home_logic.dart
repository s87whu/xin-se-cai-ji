import 'package:get/get.dart';
import 'package:xin_se_cai_ji/common/models/diary.dart';
import 'package:xin_se_cai_ji/persistence/isar.dart';
import 'package:xin_se_cai_ji/router/app_routes.dart';

class HomeLogic extends GetxController {
  final diaryList = <Diary>[].obs;
  final isSearching = false.obs;
  final searchResults = <Diary>[].obs;

  @override
  void onReady() {
    loadDiaryList();
    super.onReady();
  }

  void loadDiaryList() {
    final list = IsarUtil.getAllDiary();
    diaryList.value = list;
  }

  void searchDiary(String keyword) {
    if (keyword.isEmpty) {
      isSearching.value = false;
      searchResults.clear();
      return;
    }
    isSearching.value = true;
    searchResults.value = IsarUtil.searchDiary(keyword);
  }

  void toEditor({Diary? diary}) {
    Get.toNamed(
      AppRoutes.editorPage,
      arguments: diary,
    )?.then((_) => loadDiaryList());
  }

  void deleteDiary(String diaryId) {
    IsarUtil.deleteDiary(diaryId);
    loadDiaryList();
  }
}
