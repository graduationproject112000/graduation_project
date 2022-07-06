import 'dart:async';

import 'package:flutter/material.dart';

import '../../shared/constants.dart';
import '../home_layout/dart/home_layout.dart';
import '../login_layout/dart/login_layout.dart';

class SplashLayout extends StatefulWidget {
  const SplashLayout({Key? key}) : super(key: key);

  @override
  State<SplashLayout> createState() => _SplashLayoutState();
}

class _SplashLayoutState extends State<SplashLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return token == null ? LoginLayout() :  HomeLayout(0);
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Image.asset(
        'assets/images/splash.png',
        width: 300,
        height: 300,
      )
          // SvgPicture.asset(
          //   'assets/images/splash.svg',
          //   width: 300,
          //   height: 300,
          // ),
          ),
    );
  }
}
