import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalSeconds = 1500;
  bool isRunning = false;

  late Timer timer; //late : 나중에 초기화

  void onTicks(Timer timer) {
    setState(() {
      totalSeconds -= 1;
    });
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTicks,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1, //ratio
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                '$totalSeconds',
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: IconButton(
                iconSize: 120,
                color: Theme.of(context).cardColor,
                onPressed: isRunning ? onPausePressed : onStartPressed,
                icon: Icon(
                  isRunning
                      ? Icons.pause_circle_filled_outlined
                      : Icons.play_circle_fill_outlined,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  // ui를 확장해줌
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                            fontSize: 58,
                            color: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
