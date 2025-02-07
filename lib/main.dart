import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:med_app/app/app_module.dart';
import 'package:med_app/modules/medicine_data/database/medicines_dao.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MedicinesDao.init();
  runApp(ModularApp(module: AppModule(), child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Modular.routerConfig,
      debugShowCheckedModeBanner: false,
    );
  }
}
