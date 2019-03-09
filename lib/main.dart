import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pacman/game.dart';

void main() {
  final StreamController sb = StreamController();
  final game = new PacmanGame(
    onStateChanged: () {
      sb.add(const Object());
    }
  );

  runApp(MaterialApp(
    home: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(child: game.widget),
        StreamBuilder(
          stream: sb.stream,
          builder: (context, _) {
            return Container(
              color: Colors.teal,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('Score', style: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),),
                    ),
                    Text("${game.points}", style: TextStyle(
                      fontSize: 32,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),),
                  ],
                ),
              ),
            );
          },
        ),
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