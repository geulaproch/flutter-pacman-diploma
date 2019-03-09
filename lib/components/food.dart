import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:pacman/components/component.dart';

enum FoodType {
  small,
  big,
}

class Food extends Component {
  final FoodType type;
  final Sprite sprite;

  Food({this.type = FoodType.small}): sprite = Sprite(nameForType(type));

  @override
  void render(Canvas canvas, double x, double y, double w, double h) {
    canvas.save();
    canvas.translate(x, y);

    sprite.render(canvas, w, h);

    canvas.restore();
  }

  static String nameForType(FoodType type) {
    switch(type) {
      case FoodType.small:
        return 'food_small.png';
      case FoodType.big:
        return 'food.png';
    }
  }
}