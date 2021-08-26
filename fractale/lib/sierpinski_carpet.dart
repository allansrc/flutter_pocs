import 'package:flutter/material.dart';
import 'dart:math' as Math;

class SierpinskiCarpet extends CustomPainter {
  num carpetWidth = 0;
  num carpetHeight = 0;
  num totalSteps = 0;
  num currentStep = 0;
  double offsetX = 0;
  double offsetY = 0;

  @override
  void paint(Canvas canvas, Size size) {
    num squareSize = Math.min(size.width, size.height);
    if (size.width == size.height) {
      offsetX = 0;
      offsetY = 0;
    } else if (size.width > size.height) {
      offsetX = (size.width - size.height) / 2;
    } else {
      offsetY = (size.height - size.width) / 2;
    }

    carpetWidth = squareSize;
    carpetHeight = squareSize;

    totalSteps = 5;

    Paint p = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    drawCarpet(canvas, p, 1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void drawCarpet(Canvas canvas, Paint p, int step) {
    num rows = Math.pow(3, step);
    num partW = carpetWidth / rows;
    num partH = carpetHeight / rows;

    for (num i = 0; i < rows; i++) {
      for (num k = 0; k < rows; k++) {
        if (i % 3 == 1 && k % 3 == 1) {
          double x = offsetX + (partW * i);
          double y = offsetY + (partH * k);
          canvas.drawRect(Rect.fromPoints(Offset(x, y), Offset(x + partW, y + partH)), p);
        }
      }
    }

    if (step < totalSteps) drawCarpet(canvas, p, ++step);
  }
}
