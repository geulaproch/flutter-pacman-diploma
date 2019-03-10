import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pacman/game.dart';

void main() {
  final StreamController sb = StreamController();
  final StreamController resetGame = StreamController();

  PacmanGame game;

  runApp(MaterialApp(
    home: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: StreamBuilder(
            stream: resetGame.stream,
            builder: (context, _) {
              var newGame = PacmanGame(
                  onStateChanged: () {
                    sb.add(const Object());
                  },
                  onPlayerDead: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("GameOver"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                resetGame.add(const Object());
                              },
                              child: Text("Restart"),
                            ),
                          ],
                        );
                      }
                    );
                  }
              );

              if (game != null) {
                newGame.resize(game.size);
              }
              game = newGame;

              return game.widget;
            },
          ),
        ),
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
              FlatButton.icon(onPressed: () => game.onArrowLeft(), icon: Icon(Icons.arrow_left), label: Text("Left")),
              Column(
                children: <Widget>[
                  FlatButton.icon(onPressed: () => game.onArrowUp(), icon: Icon(Icons.arrow_upward), label: Text("Up")),
                  FlatButton.icon(onPressed: () => game.onArrowDown(), icon: Icon(Icons.arrow_downward), label: Text("Down")),
                ],
              ),
              FlatButton.icon(onPressed: () => game.onArrowRight(), icon: Icon(Icons.arrow_right), label: Text("Right")),
            ],
          ),
        )
      ],
    ),
  ));
}