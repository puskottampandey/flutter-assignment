import 'dart:async';

import 'package:flutter/material.dart';

import '../constant/constant.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/Home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kcolor,
    );
  }
}
