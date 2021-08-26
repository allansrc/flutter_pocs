import 'package:flutter/material.dart';
import 'dart:math' as Math;

class DragonCurve extends CustomPainter {
  static String left = 'l';
  static String right = 'r';
  num totalSteps = 7;
  num dragonWidth = 0;
  num dragonHeight = 0;
  num currentStep = 0;
  String route = '';

  @override
  void paint(Canvas canvas, Size size) {
    dragonWidth = size.width;
    dragonHeight = size.height;

    route = getNext(right, 1);

    Paint p = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.bevel
      ..strokeWidth = 0.5;

    Path path = Path();
    drawDragon(path);
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void drawDragon(Path _path) {
    num angle = -Math.pi * 0.25;
    num angleIncrement = Math.pi * 0.5;
    num segmentLength = calculateLength(dragonWidth, dragonHeight);
    num previousX = 0;
    num previousY = 0;
    double currentX = 0;
    double currentY = 0;

    List<String> steps = route.split("");

    for (int i = 0; i < steps.length; i++) {
      angle += steps[i] == right ? -angleIncrement : angleIncrement;

      currentX = segmentLength * Math.cos(angle);
      currentX += previousX;
      currentY = segmentLength * Math.sin(angle);
      currentY += previousY;

      _path.lineTo(currentX, currentY);

      previousX = currentX;
      previousY = currentY;
    }
  }

  num calculateLength(num w, num h) {
    if (w / h < 1.5) {
      w = h / 2 * 3;
    }
    num l = w / Math.pow(Math.sqrt(2), totalSteps + 1);
    return l;
  }

  String getNext(String route, num step) {
    String newRoute = route + right;
    List<String> steps = route.split("");
    for (int i = steps.length - 1; i >= 0; i--) {
      newRoute += (steps[i] == right) ? left : right;
    }
    if (step < totalSteps) {
      route = getNext(newRoute, ++step);
    }
    return route;
  }
}
