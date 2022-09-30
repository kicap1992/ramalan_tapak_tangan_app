import 'package:flutter/cupertino.dart';

import '../pages/index.dart';
import '../pages/splash_screen.dart';

class RoutesApp {
  static getRoutes() {
    return {
      'splash': (BuildContext context) => const SplashScreen(),
      'index': (BuildContext context) => const IndexPage(),
    };
  }
}
