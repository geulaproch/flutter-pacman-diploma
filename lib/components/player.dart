import 'dart:ui';
import 'dart:math';

import 'package:flame/animation.dart';
import 'package:flame/sprite.dart';
import 'package:pacman/components/component.dart';

enum Facing {
  up,
  down,
  left,
  right
}

class Player extends Component {
  final Animation a = new Animation.spriteList([
    Sprite('pacman_1.png'),
    Sprite('pacman_2.png'),
    Sprite('pacman_3.png'),
  ], stepTime: 0.15, loop: true);

  final degToRad = pi / 180;
  var direction = Facing.up;

  @override
  void render(Canvas canvas, double x, double y, double w, double h) {
    canvas.save();
    canvas.translate(x, y);

    switch (direction) {
      case Facing.down:
        canvas.translate(w, 0);
        canvas.rotate(90.0 * degToRad);
        break;
      case Facing.left:
        canvas.scale(1, -1);
        canvas.translate(w, 0);
        canvas.rotate(180.0 * degToRad);
        break;
      case Facing.up:
        canvas.translate(0, h);
        canvas.rotate(270.0 * degToRad);
        break;
      case Facing.right:
        break;
    }

    a.getSprite().render(canvas, w, h);

    canvas.restore();
  }

  @override
  void update(double t) {
    a.update(t);
  }
}