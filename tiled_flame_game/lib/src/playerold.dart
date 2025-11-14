import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/src/services/hardware_keyboard.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:tiled_flame_game/src/collisions/collision_shape.dart';
import 'package:tiled_flame_game/src/collisions/custom_hitbox.dart';

import 'package:tiled_flame_game/src/my_game.dart';

enum PlayerOldState {
  idleUp("walk-up", 1),
  idleDown("walk-down", 1),
  idleRight("walk-right", 1),
  idleLeft("walk-left", 1),
  walkUp("walk-up", 4),
  walkDown("walk-down", 4),
  walkRight("walk-right", 4),
  walkLeft("walk-left", 4);

  final String assetName;
  final int frameCount;
  const PlayerOldState(this.assetName, this.frameCount);
}

class PlayerOld extends SpriteAnimationGroupComponent
    with HasGameReference<MyGame>, KeyboardHandler {
  PlayerOld({super.position});

  late final Vector2 startingPosition;

  late final SpriteAnimation walkUpIdle;
  late final SpriteAnimation walkDownIdle;
  late final SpriteAnimation walkRightIdle;
  late final SpriteAnimation walkLeftIdle;
  late final SpriteAnimation walkUpAnimation;
  late final SpriteAnimation walkDownAnimation;
  late final SpriteAnimation walkRightAnimation;
  late final SpriteAnimation walkLeftAnimation;

  Vector2 direction = Vector2.zero();
  double speed = 100.0;

  CustomHitbox hitbox = const CustomHitbox(
    offsetX: 3,
    offsetY: 6,
    width: 9,
    height: 10,
  );

  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    startingPosition = position;

    _loadAllAnimations();
    add(
      RectangleHitbox(
        position: Vector2(hitbox.offsetX, hitbox.offsetY),
        size: Vector2(hitbox.width, hitbox.height),
      ),
    );

    return super.onLoad();
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isLeftKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);
    final isUpKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.keyW) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp);
    final isDownKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.keyS) ||
        keysPressed.contains(LogicalKeyboardKey.arrowDown);

    if (isLeftKeyPressed) {
      direction = Vector2(-1.0, direction.y);
    } else if (isRightKeyPressed) {
      direction = Vector2(1.0, direction.y);
    } else {
      direction = Vector2(0.0, direction.y);
    }

    if (isUpKeyPressed) {
      direction = Vector2(direction.x, -1.0);
    } else if (isDownKeyPressed) {
      direction = Vector2(direction.x, 1.0);
    } else {
      direction = Vector2(direction.x, 0.0);
    }

    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void update(double dt) {
    position += direction * speed * dt;
    _updatePlayerState();
    super.update(dt);
  }

  void _updatePlayerState() {
    switch (direction.x) {
      case 1.0:
        current = PlayerOldState.walkRight;
        return;
      case -1.0:
        current = PlayerOldState.walkLeft;
        return;
    }
    switch (direction.y) {
      case 1.0:
        current = PlayerOldState.walkDown;
        return;
      case -1.0:
        current = PlayerOldState.walkUp;
        return;
    }
    current = PlayerOldState.idleDown;
  }

  void _loadAllAnimations() {
    walkUpIdle = _spriteAnimation(PlayerOldState.idleUp);
    walkDownIdle = _spriteAnimation(PlayerOldState.idleDown);
    walkLeftIdle = _spriteAnimation(PlayerOldState.idleLeft);
    walkRightIdle = _spriteAnimation(PlayerOldState.idleRight);
    walkUpAnimation = _spriteAnimation(PlayerOldState.walkUp);
    walkDownAnimation = _spriteAnimation(PlayerOldState.walkDown);
    walkLeftAnimation = _spriteAnimation(PlayerOldState.walkLeft);
    walkRightAnimation = _spriteAnimation(PlayerOldState.walkRight);

    animations = {
      PlayerOldState.idleUp: walkUpIdle,
      PlayerOldState.idleDown: walkDownIdle,
      PlayerOldState.idleLeft: walkLeftIdle,
      PlayerOldState.idleRight: walkRightIdle,
      PlayerOldState.walkUp: walkUpAnimation,
      PlayerOldState.walkDown: walkDownAnimation,
      PlayerOldState.walkLeft: walkLeftAnimation,
      PlayerOldState.walkRight: walkRightAnimation,
    };

    current = PlayerOldState.idleDown;
  }

  SpriteAnimation _spriteAnimation(PlayerOldState state) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache("${state.assetName}.png"),
      SpriteAnimationData.sequenced(
        amount: state.frameCount,
        stepTime: 0.1,
        textureSize: Vector2.all(16),
      ),
    );
  }
}
