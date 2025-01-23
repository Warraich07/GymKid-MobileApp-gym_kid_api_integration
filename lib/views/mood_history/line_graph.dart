import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gym_kid/res/colors.dart';

class LineGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CustomPaint(
          painter: LineGraphPainter(),
        ),
      ),
    );
  }
}

class LineGraphPainter extends CustomPainter {
  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final Paint paintLine = Paint()
      ..color = AppColors.secondaryColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final Paint paintPoint = Paint()
      ..color = Color(0xffA3A3A3)
      ..style = PaintingStyle.fill;

    List<Point> points = [
      Point(20, 150),
      Point(60, 80),
      Point(110, 10),
      Point(150, 80),
      Point(200, 50),
      Point(250, 50),
    ];

    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(
        Offset(points[i].x, points[i].y),
        Offset(points[i + 1].x, points[i + 1].y),
        paintLine,
      );
    }

    for (var point in points) {
      canvas.drawCircle(Offset(point.x, point.y), 5.0, paintPoint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
}
