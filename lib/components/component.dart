import 'dart:ui';

abstract class Component {
  void render(Canvas canvas, double x, double y, double w, double h);
  void update(double t) {}
}