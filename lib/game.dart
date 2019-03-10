import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/src/gestures/recognizer.dart';
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

  Point _playerPosition;

  VoidCallback onStateChanged;

  Point get playerPosition => _playerPosition;
  set playerPosition (Point point) {
    print("set playerPosition - $point");
    final player = map.remove(_playerPosition);

    if (point == null) {
      map.remove(_playerPosition);
      _playerPosition = null;
    } else if (player != null) {
      _playerPosition = point;
      map[point] = player;
    }

    print("_playerPosition - $_playerPosition");
  }

  Size size;

  Player get player => map[playerPosition];

  int points = 0;

  PacmanGame({
    this.onStateChanged
  }) {
    addWalls();
    addFood();
    addPlayer();
    addGhosts();
    //Flame.util.addGestureRecognizer(createTapRecognizer());
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
    final startingPosition = Point((columns/2).floor(), (rows/2).floor());
    map[startingPosition] = Player();
    _playerPosition = startingPosition;

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
    map.forEach((position, component) {
      component.update(t);
    });
  }

  @override
  void resize(Size size) {
    this.size = size;

    mazeWidth = size.width;
    mazeStartX = 0;

    squareWidth = mazeWidth / columns;
    squareHeight = squareWidth;

    mazeHeight = squareHeight * rows;
    mazeStartY = (size.height - mazeHeight) / 2;
  }
/*
  GestureRecognizer createTapRecognizer() {
    return new TapGestureRecognizer()
      ..onTapUp = (TapUpDetails details) => this.handleTap(details.globalPosition);
  }

  handleTap(Offset globalPosition) {

  }*/

  void movePlayer(offsetX, offsetY) {
    if (playerPosition == null) {
      return;
    }

    var futurePosition = Point(playerPosition.x + offsetX, playerPosition.y + offsetY);
    if (map[futurePosition] is Wall) {
      return;
    }

    if (map[futurePosition] is Ghost) {
      die();
    }

    if (futurePosition.x < 0) {
      futurePosition = Point(playerPosition.x + offsetX + columns, playerPosition.y + offsetY);
    }

    if (futurePosition.x >= columns) {
      futurePosition = Point(0, playerPosition.y + offsetY);
    }

    if (map[futurePosition] is Food) {
      points += 10;
      onStateChanged();
    }

    playerPosition = futurePosition;
  }

  void onArrowLeft() {
    movePlayer(-1, 0);
    player.direction = Facing.left;
  }

  void onArrowUp() {
    movePlayer(0, -1);
    player.direction = Facing.up;
  }

  void onArrowDown() {
    movePlayer(0, 1);
    player.direction = Facing.down;
  }

  void onArrowRight() {
    movePlayer(1, 0);
    player.direction = Facing.right;
  }

  void die() {
    points = 0;
    onStateChanged();
    playerPosition = null;
  }
}