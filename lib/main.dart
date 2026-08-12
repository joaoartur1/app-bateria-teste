import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_bateria/features/battery/data/datasources/battery_local_datasource.dart';
import 'package:app_bateria/features/battery/data/datasources/battery_native_datasource.dart';
import 'package:app_bateria/features/battery/data/repositories/battery_repository_impl.dart';
import 'package:app_bateria/features/battery/presentation/controllers/battery_controller.dart';
import 'package:app_bateria/features/battery/presentation/pages/home_page.dart';

void main() {
  final nativeDataSource = BatteryNativeDataSource();
  final localDataSource = BatteryLocalDataSource();

  final repository = BatteryRepositoryImpl(
    nativeDataSource: nativeDataSource,
    localDataSource: localDataSource,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BatteryController(repository)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF2563EB);

    return MaterialApp(
      title: 'Battery Monitor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF8FAFC),
          elevation: 0,
          centerTitle: false,
        ),
        cardTheme: const CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
