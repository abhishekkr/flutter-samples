import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:flutter/widgets.dart';

import 'package:dino_run/game/actions/buttonJump.dart';
import 'package:dino_run/game/actions/joystick.dart';
import 'package:dino_run/game/player.dart';
import 'package:dino_run/game/background.dart';

class DinoRun extends FlameGame with KeyboardEvents {
  DinoRun();

  late final Player dino;
  late final LevelBackground levelbg;
  late final GameJoystick joystick;
  late final ButtonJump btnJump;

  @override
  FutureOr<void> onLoad() async {
    dino = Player();
    levelbg = LevelBackground();
    joystick = GameJoystick(
      onIdle: dino.handleJoystickDragStop,
      bigRadius: 90.0,
    );
    btnJump = ButtonJump(
      onTap: dino.doJump,
      btnSize: Vector2(60.0, 35.0),
      btnAngle: 0.0,
    );

    add(levelbg);
    add(joystick);
    add(dino);
    add(btnJump);

    return super.onLoad();
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (keysPressed.contains(LogicalKeyboardKey.enter) ||
        keysPressed.contains(LogicalKeyboardKey.space)) {
      dino.doJump();
    }
    return super.onKeyEvent(event, keysPressed);
  }

  void reload() {
    removeAll(children);
    onLoad();
  }
}
