import 'dart:math';
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:pacman/components/component.dart';
import 'package:pacman/components/food.dart';
import 'package:pacman/components/ghost.dart';
import 'package:pacman/components/player.dart';
import 'package:pacman/components/wall.dart';

class PacmanGame extends Game {
  final columns = 16;
  final rows = 21;
  double mazeWidth, mazeHeight, mazeStartX, mazeStartY, squareWidth, squareHeight;

  final map = Map<Point, Component>();

  Point playerPosition;

  Player get player => map[playerPosition];

  PacmanGame() {
    addWalls();
    addFood();
    addPlayer();
    addGhosts();
  }

  void addWalls() {
    for (var i = 0.0; i < columns; i++) {
      map[Point(i, 0)] = Wall();
      map[Point(i, rows - 1.0)] = Wall();
    }

    for (var j = 1.0; j < rows - 1; j++) {
      if (j == (rows / 2).floor()) {
        continue;
      }

      map[Point(0, j)] = Wall();
      map[Point(columns - 1.0, j)] = Wall();
    }

    for (var i = 2.0; i < rows - 2; i+=2) {
      for (var j = 2.0; j < columns - 2; j+=2) {
        if (Random().nextBool()) {
          map[Point(j, i)] = Wall();
        }
      }
    }
  }

  void addFood() {
    for (var i = 0.0; i < columns; i++) {
      for (var j = 0.0; j < rows; j++) {
        var position = Point(i, j);

        if (!map.containsKey(position)) {
          map[position] = Food();
        }
      }
    }
  }

  void addPlayer() {
    map[Point((columns/2).floor(), (rows/2).floor())] = Player();
  }

  void addGhosts() {
    var horizontal = (rows/2).floor();
    var vertical = (columns/2).floor();

    map[Point(horizontal, vertical)] = Ghost();
    map[Point(vertical-2, horizontal-2)] = Ghost();
    map[Point(horizontal-2, vertical-2)] = Ghost();
  }

  @override
  void render(Canvas canvas) {
    map.forEach((position, component) {
      component.render(canvas,
        (position.x * squareWidth) + mazeStartX,
        (position.y * squareHeight) + mazeStartY,
        squareWidth, squareHeight,
      );
    });
  }

  @override
  void update(double t) {
  }

  @override
  void resize(Size size) {
    mazeWidth = size.width;
    mazeStartX = 0;

    squareWidth = mazeWidth / columns;
    squareHeight = squareWidth;

    mazeHeight = squareHeight * rows;
    mazeStartY = (size.height - mazeHeight) / 2;
  }

}