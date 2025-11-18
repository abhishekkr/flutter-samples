import 'dart:async';

import 'package:dino_run/game/background.dart';
import 'package:flame/game.dart';

import 'package:dino_run/game/game_joystick.dart';
import 'package:dino_run/game/player.dart';

class DinoRun extends FlameGame {
  DinoRun();

  late final Player dino = Player();
  late final LevelBackground levelbg = LevelBackground();
  late final GameJoystick joystick = GameJoystick();

  @override
  FutureOr<void> onLoad() async {
    add(levelbg);
    add(joystick);
    add(dino);
    joystick.position = size / 2;

    return super.onLoad();
  }

  void reload() {
    removeAll(children);
    onLoad();
  }
}
