import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'src/config/routes.dart';
import 'src/config/theme.dart';
import 'src/services/storage_service.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  StorageService storage = StorageService();
  await storage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ramalamn Tapak Tangan',
      theme: ThemeInfo.getTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      routes: RoutesApp.getRoutes(),
      builder: EasyLoading.init(),
    );
  }
}
