import 'dart:async';

import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static Route route() => MaterialPageRoute<void>(
    builder: (_) => const SplashScreen(),
  );
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      print('hello');
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('SPLASH ENTERED');
    debugPrint('SPLASH WORKED');
     return const Scaffold(
      backgroundColor: Colors.white,
      body:Center(
        child: Text('TestTask', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black),),
      ),
    );
  }

 }
