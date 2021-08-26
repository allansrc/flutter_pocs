import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as Math;

class KochSnowflake extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double sideLength = Math.min(size.width, size.height);
    double down = (sideLength / 2) * Math.tan(Math.pi / 6);
    double up = (sideLength / 2) * Math.tan(Math.pi / 3) - down;
    Point p1 = Point(-sideLength / 2, down);
    Point p2 = Point(sideLength / 2, down);
    Point p3 = Point(0, -up);
    Point p4 = Point(0, 0);
    Point p5 = Point(0, 0);
    double rot = 0.0;
    List<Point> lines = <Point>[p1, p2, p3];
    List<Point> tmpLines = <Point>[];

    int totalIterations = 7;

    for (int iterations = 0; iterations < totalIterations; iterations++) {
      sideLength /= 3;
      for (int loop = 0; loop < lines.length; loop++) {
        p1 = lines[loop];
        if (loop == lines.length - 1) {
          p2 = lines[0];
        } else {
          p2 = lines[loop + 1];
        }
        rot = Math.atan2(p2.y - p1.y, p2.x - p1.x);
        p3 = p1 + Point(sideLength, rot);
        rot += Math.pi / 3;
        p4 = p3 + Point(sideLength, rot);
        rot -= 2 * Math.pi / 3;
        p5 = p4 + Point(sideLength, rot);
        tmpLines.add(p1);
        tmpLines.add(p3);
        tmpLines.add(p4);
        tmpLines.add(p5);
      }
      lines = tmpLines;
      tmpLines = <Point>[];
    }
    if (totalIterations > 0) {
      lines.add(p2);
    }

    Paint p = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..style = PaintingStyle.fill
      ..strokeJoin = StrokeJoin.bevel
      ..strokeWidth = 2;

    Path path = Path();
    path.moveTo(lines[0].x.toDouble(), lines[0].y.toDouble());
    for (int i = 0; i < lines.length; i++) {
      path.lineTo(lines[i].x.toDouble(), lines[i].y.toDouble());
    }
    path.lineTo(lines[0].x.toDouble(), lines[0].y.toDouble());

    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
