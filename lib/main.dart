import 'package:flutter/material.dart';
import 'package:pacman/game.dart';

void main() {
  final game = new PacmanGame();
  runApp(MaterialApp(
    home: Column(
      children: <Widget>[
        Expanded(child: game.widget),
        Container(
          color: Colors.teal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(onPressed: game.onArrowLeft, icon: Icon(Icons.arrow_left), label: Text("Left")),
              Column(
                children: <Widget>[
                  FlatButton.icon(onPressed: game.onArrowUp, icon: Icon(Icons.arrow_upward), label: Text("Up")),
                  FlatButton.icon(onPressed: game.onArrowDown, icon: Icon(Icons.arrow_downward), label: Text("Down")),
                ],
              ),
              FlatButton.icon(onPressed: game.onArrowRight, icon: Icon(Icons.arrow_right), label: Text("Right")),
            ],
          ),
        )
      ],
    ),
  ));
}