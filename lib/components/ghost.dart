import 'dart:ui';

import 'package:flame/animation.dart';
import 'package:flame/sprite.dart';
import 'package:pacman/components/component.dart';

class Ghost extends Component {
  final Animation a = new Animation.spriteList([
    Sprite('ghost_1.png'),
    Sprite('ghost_2.png'),
  ], stepTime: 0.15, loop: true);


  @override
  void render(Canvas canvas, double x, double y, double w, double h) {
    canvas.save();
    canvas.translate(x, y);

    a.getSprite().render(canvas, w, h);

    canvas.restore();
  }

  @override
  void update(double t) {
    a.update(t);
  }
}