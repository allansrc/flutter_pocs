import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as Math;

class BranchingTree extends CustomPainter {
  num maxSubBranch = 2;
  num maxSubAngle = 3 * Math.pi / 4;
  double maxBranchSize = 8;
  num branchLength = 50;

  @override
  void paint(Canvas canvas, Size size) {
    drawBrach(canvas, Point(size.width / 2, size.height), branchLength, -Math.pi / 2, maxBranchSize);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void drawBrach(Canvas c, Point start, num length, num angle, double size) {
    if (size > 0) {
      Paint p = Paint()
        ..color = Colors.brown.shade700
        ..style = PaintingStyle.stroke
        ..strokeJoin = StrokeJoin.bevel
        ..strokeWidth = size;

      if (size < 2) {
        num odds = Math.Random.secure().nextDouble();
        if (odds > 0.8) {
          p.color = Colors.red.shade700;
        } else if (odds > 0.6) {
          p.color = Colors.yellow.shade800;
        } else {
          p.color = Colors.green.shade700;
        }
      }

      Path path = Path();
      path.moveTo(start.x.toDouble(), start.y.toDouble());
      Point end = Point(start.x + length * Math.cos(angle), start.y + length * Math.sin(angle));
      path.lineTo(end.x.toDouble(), end.y.toDouble());
      c.drawPath(path, p);

      var generator = Math.Random.secure();
      num subBranch = maxSubBranch + 1;
      num branchLengthCutter = .5 + generator.nextDouble() / 2;
      for (int i = 0; i < subBranch; i++) {
        num newBranchLength = length * branchLengthCutter;
        num newBranchAngle = angle + generator.nextDouble() * maxSubAngle - maxSubAngle / 2;
        double newBrachSize = size - 1;
        drawBrach(c, end, newBranchLength, newBranchAngle, newBrachSize);
      }
    }
  }
}
