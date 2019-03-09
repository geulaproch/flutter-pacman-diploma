import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pacman/components/component.dart';

class Ghost extends Component {
  final paint = Paint()
    ..color = Colors.lightBlueAccent;

  @override
  void render(Canvas canvas, double x, double y, double w, double h) {
    canvas.drawRect(
      Rect.fromLTWH(x, y, w, h),
      paint,
    );
  }
}