import 'dart:async';

import 'package:df_log/df_log.dart';
import 'package:flame/components.dart';

import 'package:dino_run/game/mygame.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent with HasGameReference<DinoRun> {
  final spritePath = "DinoSprites_doux.png";
  final speed = 3.0;
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

  late final Map<String, SpriteAnimation> animations;

  @override
  FutureOr<void> onLoad() async {
    final spriteImage = await game.images.load("DinoSprites_doux.png");
    final spriteSheet = SpriteSheet(
      image: spriteImage,
      srcSize: Vector2.all(24),
    );

    animations = {
      'idle': spriteSheet.createAnimation(
        row: 0,
        stepTime: 0.1,
        from: 0,
        to: 3,
      ),
      'run': spriteSheet.createAnimation(
        row: 0,
        stepTime: 0.1,
        from: 4,
        to: 10,
      ),
    };

    animation = animations['idle'];

    size = Vector2.all(90);
    position = game.size / 2;
    anchor = Anchor.center;

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (game.joystick.direction == JoystickDirection.idle) {
      animation = animations['idle'];
    } else {
      _move_player(dt);
    }

    super.update(dt);
  }

  void _move_player(double dt) {
    var pos = Vector2(x, y);
    if (dirX.contains(game.joystick.direction)) {
      pos.x += speed * game.joystick.delta.x * dt;
      if (game.joystick.delta.x < 0) {
        scale.x = -1;
      } else if (game.joystick.delta.x > 0) {
        scale.x = 1;
      }
    }
    if (dirY.contains(game.joystick.direction)) {
      pos.y += speed * game.joystick.delta.y * dt;
    }
    position = Vector2(
      pos.x.clamp(0, game.size.x),
      pos.y.clamp(0, game.size.y),
    );
    animation = animations['run'];
    Log.ok(
      "direction: ${game.joystick.direction}; position: ${position}; joys:delta: ${game.joystick.delta}",
    );
  }
}
