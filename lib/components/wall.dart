import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:pacman/components/component.dart';

class Wall extends Component {
  final sprite = Sprite('wall.png');

  @override
  void render(Canvas canvas, double x, double y, double w, double h) {
    canvas.save();
    canvas.translate(x, y);

    sprite.render(canvas, w, h);

    canvas.restore();
  }
}