import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wakelock/wakelock.dart';

import './pages/home.dart';
import './pages/sipr.dart';
import './pages/nakes.dart';
import './pages/kkpr.dart';
import './pages/skp.dart';
import './pages/perling.dart';
import './pages/mbr.dart';
import './pages/riwayat.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      builder: EasyLoading.init(),
      getPages: [
        GetPage(
          name: "/home",
          page: () => const HomePage(),
        ),
        GetPage(
          name: "/nakes",
          page: () => const Nakes(),
        ),
        GetPage(
          name: "/kkpr",
          page: () => const KKPR(),
        ),
        GetPage(
          name: "/sipr",
          page: () => const SIPR(),
        ),
        GetPage(
          name: "/skp",
          page: () => const SKP(),
        ),
        GetPage(
          name: "/perling",
          page: () => const Perling(),
        ),
        GetPage(
          name: "/mbr",
          page: () => const MBR(),
        ),
        GetPage(
          name: "/riwayat",
          page: () => const Riwayat(),
        ),
      ],
    );
  }
}
