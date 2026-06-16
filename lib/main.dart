import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xin_se_cai_ji/persistence/isar.dart';
import 'package:xin_se_cai_ji/persistence/pref.dart';
import 'package:xin_se_cai_ji/router/app_pages.dart';
import 'package:xin_se_cai_ji/router/app_routes.dart';
import 'package:xin_se_cai_ji/common/values/keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefUtil.initPref();
  await IsarUtil.initIsar();
  runApp(const MyApp());
}

String _getInitialRoute() {
  if (PrefUtil.containsKey(PrefKeys.lock) && PrefUtil.getValue<bool>(PrefKeys.lock)) {
    return AppRoutes.lockPage;
  }
  return AppRoutes.homePage;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = ThemeMode.values[PrefUtil.getValue<int>(PrefKeys.themeMode)];
    return GetMaterialApp(
      title: '心色彩记',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF6750A4),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: const Color(0xFF6750A4),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: themeMode,
      initialRoute: _getInitialRoute(),
      getPages: AppPages.routes,
    );
  }
}