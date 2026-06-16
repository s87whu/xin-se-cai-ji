import 'package:get/get.dart';
import 'package:moodiary/router/app_routes.dart';
import 'package:moodiary/pages/home/home_view.dart';
import 'package:moodiary/pages/editor/editor_view.dart';
import 'package:moodiary/pages/analyse/analyse_view.dart';
import 'package:moodiary/pages/assistant/assistant_view.dart';
import 'package:moodiary/pages/settings/settings_view.dart';
import 'package:moodiary/pages/lock/lock_view.dart';
import 'package:moodiary/pages/agreement/agreement_view.dart';
import 'package:moodiary/pages/privacy/privacy_view.dart';

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
