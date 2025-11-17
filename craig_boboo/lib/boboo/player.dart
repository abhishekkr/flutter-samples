import 'dart:async';

import 'package:df_log/df_log.dart';
import 'package:flame/components.dart';

import 'package:craig_boboo/boboo/mygame.dart';

class Player extends SpriteComponent with HasGameReference<BobooGame> {
  final speed = 5.0;
  final dirX = [
    JoystickDirection.right,
    JoystickDirection.left,
    JoystickDirection.downRight,
    JoystickDirection.downLeft,
    JoystickDirection.upRight,
    JoystickDirection.upLeft,
  ];
  final dirY = [
    JoystickDirection.down,
    JoystickDirection.up,
    JoystickDirection.downRight,
    JoystickDirection.upRight,
    JoystickDirection.downLeft,
    JoystickDirection.upLeft,
  ];

  @override
  FutureOr<void> onLoad() async {
    sprite = await game.loadSprite('8bit-joker.png');
    size = Vector2.all(90);
    position = game.size / 2;
    anchor = Anchor.center;

    return super.onLoad();
  }

  @override
  void update(double dt) {
    var pos = Vector2(x, y);
    if (game.joystick.direction != JoystickDirection.idle) {
      if (dirX.contains(game.joystick.direction)) {
        pos.x += speed * game.joystick.delta.x * dt;
      }
      if (dirY.contains(game.joystick.direction)) {
        pos.y += speed * game.joystick.delta.y * dt;
      }
      position = Vector2(
        pos.x.clamp(0, game.size.x),
        pos.y.clamp(0, game.size.y),
      );
      Log.ok("direction: ${game.joystick.direction}; position: ${position}");
    }

    super.update(dt);
  }
}
