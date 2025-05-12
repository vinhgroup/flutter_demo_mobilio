import 'dart:async';
import 'package:flutter/material.dart';

import '../../example_mobilio/screen/mobilio_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initCall();
  }

  Future<void> initCall() async {
    Timer(const Duration(seconds: 1), () async {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const MobilioScreen()));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: Text(
              'Molibio',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.orange,
              ),
            ),
          ),
        ));
  }
}
