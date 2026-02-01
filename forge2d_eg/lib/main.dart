import 'package:flutter/widgets.dart';
import 'package:forge2d_eg/my_forge2d_game.dart';
import 'package:flame/game.dart';

void main() {
  runApp(const GameWidget.controlled(gameFactory: MyForge2dGame.new));
}
