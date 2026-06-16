import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moodiary/persistence/isar.dart';
import 'package:moodiary/persistence/pref.dart';
import 'package:moodiary/router/app_pages.dart';
import 'package:moodiary/router/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefUtil.initPref();
  await IsarUtil.initIsar();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = ThemeMode.values[PrefUtil.getValue<int>('themeMode')];
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
      initialRoute: AppRoutes.homePage,
      getPages: AppPages.routes,
    );
  }
}
