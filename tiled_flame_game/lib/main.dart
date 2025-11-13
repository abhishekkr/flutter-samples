import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tiled_flame_game/src/my_game.dart';

void main() {
  final gameWidget = GameWidget(
    game: MyGame(),
    );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Focus(
        onKeyEvent: (node, event) => KeyEventResult.handled,
        child: gameWidget,
        ),
      ),
  );
}
