import 'package:cek_tapak_tangan/src/config/theme.dart';
import 'package:flutter/material.dart';

import '../services/other_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // initPlatformState();
    // future 3 sec

    Future.delayed(const Duration(seconds: 4), () async {
      // await _storage.remove('userData');
      await OtherServices.cekAndDelete();
      goToIndex();
    });
  }

  goToIndex() {
    Navigator.pushReplacementNamed(context, 'index');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeInfo.primary,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/tapak_tangan.png',
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.8,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            child: const Center(
              child: Text(
                "Membaca Garis \nTelapak Tangan",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeInfo.background,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            child: const Center(
              child: Text(
                "Created By \nKicap Karan",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeInfo.background,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
