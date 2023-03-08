import 'dart:async';

import 'package:app_test_infinite/screen_infinite.dart';
import 'package:flutter/material.dart';

class ScaScreen extends StatefulWidget {
  const ScaScreen({super.key});

  @override
  State<ScaScreen> createState() => _ScaScreenState();
}

class _ScaScreenState extends State<ScaScreen> {
  late Timer timer;
  int timerCount = 0;

  void _timerFunc(Timer timer) {
    if (mounted) {
      setState(() {
        timerCount++;
        if (timerCount > 10000) {
          timerCount = 0;
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    print('scaffold screen init');
    timer = Timer.periodic(const Duration(microseconds: 30), (timer) {
      _timerFunc(timer);
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scaffold $timerCount ...ing'),
      ),
      body: const ReflectBall(
        mapXsize: 300,
        mapYsize: 500,
        xPosition: 100,
        yPosition: 200,
        ballRad: 20,
        xSpeed: 4,
        ySpeed: 4,
      ),
    );
  }
}
