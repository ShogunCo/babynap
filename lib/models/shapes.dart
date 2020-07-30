import 'package:flutter/material.dart';

class RectAndRadius {
  RectAndRadius(Color color, Canvas canvas) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = color;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(20, 20, 100, 100), Radius.circular(20)),
      paint,
    );
  }
}

class Rectangle {
  Rectangle(Color color, Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = color;

    canvas.drawOval(
      Rect.fromLTWH(size.width - 120, 40, 100, 100),
      paint,
    );
  }
}
