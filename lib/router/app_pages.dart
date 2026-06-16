import 'package:get/get.dart';
import 'package:xin_se_cai_ji/router/app_routes.dart';
import 'package:xin_se_cai_ji/pages/home/home_view.dart';
import 'package:xin_se_cai_ji/pages/editor/editor_view.dart';
import 'package:xin_se_cai_ji/pages/analyse/analyse_view.dart';
import 'package:xin_se_cai_ji/pages/assistant/assistant_view.dart';
import 'package:xin_se_cai_ji/pages/settings/settings_view.dart';
import 'package:xin_se_cai_ji/pages/lock/lock_view.dart';
import 'package:xin_se_cai_ji/pages/agreement/agreement_view.dart';
import 'package:xin_se_cai_ji/pages/privacy/privacy_view.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.homePage, page: () => const HomePage()),
    GetPage(name: AppRoutes.editorPage, page: () => const EditorPage()),
    GetPage(name: AppRoutes.analysePage, page: () => const AnalysePage()),
    GetPage(name: AppRoutes.assistantPage, page: () => const AssistantPage()),
    GetPage(name: AppRoutes.settingsPage, page: () => const SettingsPage()),
    GetPage(name: AppRoutes.lockPage, page: () => const LockPage()),
    GetPage(name: AppRoutes.agreementPage, page: () => const AgreementPage()),
    GetPage(name: AppRoutes.privacyPage, page: () => const PrivacyPage()),
  ];
}
