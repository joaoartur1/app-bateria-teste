import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bateria/features/battery/presentation/pages/home_page.dart';
import 'package:app_bateria/features/battery/data/datasources/battery_local_datasource.dart';
import 'package:app_bateria/features/battery/data/datasources/battery_native_datasource.dart';
import 'package:app_bateria/features/battery/data/repositories/battery_repository_impl.dart';
import 'package:app_bateria/features/battery/presentation/controllers/battery_controller.dart';

void main() {
  // Inicialização das dependências (Clean Architecture)
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
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Bateria',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const HomePage(),
    );
  }
}
