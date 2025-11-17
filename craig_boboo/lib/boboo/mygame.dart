import 'dart:async';

import 'package:craig_boboo/boboo/game_joystick.dart';
import 'package:craig_boboo/boboo/player.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'package:craig_boboo/boboo/myapp.dart';

class MyGame extends StatelessWidget {
  const MyGame({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: BobooGame());
  }
}

class BobooGame extends FlameGame {
  BobooGame();
  SpriteComponent roadTo = SpriteComponent();
  SpriteComponent boboo = SpriteComponent();

  late final GameJoystick joystick;

  @override
  FutureOr<void> onLoad() async {
    joystick = GameJoystick();
    boboo = Player();

    add(
      roadTo
        ..sprite = await loadSprite('random-game-bg.png')
        ..size = size,
    );
    add(boboo);
    add(joystick);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    // on update for frames
    super.update(dt);
  }
}
