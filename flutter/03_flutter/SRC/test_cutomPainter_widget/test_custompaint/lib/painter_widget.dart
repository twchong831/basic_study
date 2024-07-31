import 'dart:math';
import 'dart:ui';

import 'package:colorlizer/colorlizer.dart';
import 'package:flutter/material.dart';

class DrawInfinity extends CustomPainter {
  final Size widgetSize;
  final int counter;

  DrawInfinity({
    required this.widgetSize,
    required this.counter,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double targetX = convertXposition(0);
    final double targetY = widgetSize.height;
    print('widget size : $widgetSize');
    print('$targetX, $targetY');

    var myPainter = Paint();
    // myPainter.color = Colors.black;
    // canvas.drawLine(
    //     const Offset(0, 0),
    //     Offset(targetX, targetY),
    //     // Offset(convertYposition(width / 3), convertXposition(height * 2 / 3)),
    //     myPainter);
    // myPainter.color = Colors.yellow;
    // canvas.drawOval(
    //     Rect.fromCenter(center: const Offset(100, 150), width: 100, height: 80),
    //     myPainter);

    // draw points
    bool checked = false;
    if (counter % 2 == 0) {
      checked = true;
    }

    List<Offset> l = generatePoints(checked);
    print('get random points ${l.length}');
    // ColorLizer colorlizer = ColorLizer();
    // late Color colors;
    // if (colorlizer.getRandomColors() != null) {
    //   colors = colorlizer.getRandomColors()!;
    // }
    // myPainter.color = colors;
    // myPainter.strokeWidth = 4;
    // myPainter.strokeCap = StrokeCap.round;
    // canvas.drawPoints(
    //   PointMode.points,
    //   l,
    //   myPainter,
    // );

    ColorLizer colorlizer = ColorLizer();
    late Color colors;
    for (var i in l) {
      if (colorlizer.getRandomColors() != null) {
        colors = colorlizer.getRandomColors()!;
      }
      myPainter.color = colors;
      myPainter.strokeWidth = 4;
      myPainter.strokeCap = StrokeCap.round;
      canvas.drawPoints(PointMode.points, [i], myPainter);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  double convertXposition(double now) => (now - widgetSize.width / 2);
  List<Offset> generatePoints(bool checked) {
    List<Offset> list = [];
    int count = checked ? 100000 : 50000;
    Random random = Random();
    double x, y;

    for (int i = 0; i < count; i++) {
      x = -(widgetSize.width / 2) + widgetSize.width * random.nextDouble();
      y = widgetSize.height * random.nextDouble();
      list.add(Offset(x, y));
    }

    return list;
  }
}
