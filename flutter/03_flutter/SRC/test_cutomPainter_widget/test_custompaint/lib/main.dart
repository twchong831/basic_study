import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_custompaint/painter_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Custom painter test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool gCheckedTimer = false;
  late Timer gTimer;
  int gTimerCounter = 0;

  void initTimer() {
    gTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      timerCounter(timer);
    });
  }

  void timerCounter(Timer timer) {
    print('${timer.tick}');
    setState(() {
      gTimerCounter++;
      if (gTimerCounter > 9999) {
        gTimerCounter = 0;
      }
    });
  }

  _getWidgetSize(GlobalKey key) {
    if (key.currentContext != null) {
      final RenderBox renderBox =
          key.currentContext!.findRenderObject() as RenderBox;
      Size size = renderBox.size;
      return size;
    } else {
      return MediaQuery.of(context).size;
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey customPaintArea = GlobalKey();
    Size painterSize = _getWidgetSize(customPaintArea);
    print('rebuild scaffold : ${MediaQuery.of(context).size}');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                gCheckedTimer = !gCheckedTimer;
                if (gCheckedTimer) {
                  print('timer start');
                  initTimer();
                } else {
                  if (gTimer.isActive) {
                    print('timer end');
                    gTimer.cancel();
                  }
                }
                setState(() {});
              },
              icon: gCheckedTimer
                  ? const Icon(
                      Icons.play_arrow,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.pause,
                      color: Colors.red,
                    ),
            ),
            Expanded(
              child: CustomPaint(
                key: customPaintArea,
                painter: DrawInfinity(
                  // widgetSize: MediaQuery.of(context).size,
                  widgetSize: painterSize,
                  counter: gTimerCounter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
