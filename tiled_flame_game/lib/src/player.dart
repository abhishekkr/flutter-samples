import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import 'package:tiled_flame_game/src/my_game.dart';

enum PlayerState { walkUp, walkDown, walkRight, walkLeft }

class Player extends SpriteAnimationGroupComponent
    with HasGameReference<MyGame> {
  static const double speed = 100; // pixels per second
  static const String spriteFile = "spritesheet-16bit-player.png";

  Player({super.position});

  late final Vector2 startingPosition;

  late final SpriteAnimation walkUpAnimation;
  late final SpriteAnimation walkDownAnimation;
  late final SpriteAnimation walkRightAnimation;
  late final SpriteAnimation walkLeftAnimation;

  Vector2 velocity = Vector2.zero();

  @override
  FutureOr<void> onLoad() {
    startingPosition = position;

    _loadAllAnimations();

    return super.onLoad();
  }

  void _loadAllAnimations() {
    final spriteSheet = _loadSpritesheet(spriteFile);

    walkRightAnimation = _spriteAnimation(spriteSheet, 0);
    walkLeftAnimation = _spriteAnimation(spriteSheet, 1);
    walkDownAnimation = _spriteAnimation(spriteSheet, 2);
    walkUpAnimation = _spriteAnimation(spriteSheet, 3);

    animations = {
      PlayerState.walkUp: walkUpAnimation,
      PlayerState.walkDown: walkDownAnimation,
      PlayerState.walkLeft: walkLeftAnimation,
      PlayerState.walkRight: walkRightAnimation,
    };

    current = PlayerState.walkDown;
  }

  SpriteSheet _loadSpritesheet(String filepath) {
    var spriteImages = game.images.fromCache(filepath);
    return SpriteSheet(image: spriteImages, srcSize: Vector2.all(64));
  }

  SpriteAnimation _spriteAnimation(SpriteSheet spriteSheet, int row) {
    var loop = true;
    return SpriteAnimation.spriteList(
      List.generate(4, (index) => spriteSheet.getSprite(index, row)),
      stepTime: 0.15,
      loop: loop,
    );
  }

  void move(String direction) {
    switch (direction) {
      case 'up':
        velocity = Vector2(0, -speed);
        current = walkUpAnimation;
        break;
      case 'down':
        velocity = Vector2(0, speed);
        current = walkDownAnimation;
        break;
      case 'left':
        velocity = Vector2(-speed, 0);
        current = walkLeftAnimation;
        break;
      case 'right':
        velocity = Vector2(speed, 0);
        current = walkRightAnimation;
        break;
      default:
        velocity = Vector2.zero();
        break;
    }
  }

  @override
  void update(double dt) {
    position += velocity * dt;
    super.update(dt);
  }
}
