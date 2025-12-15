import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';

import 'package:dino_run/game/mygame.dart';
import 'package:dino_run/game/enemy_type.dart';

enum EnemyState { run, hit }

class Enemy extends SpriteAnimationComponent
    with HasGameReference<DinoRun>, CollisionCallbacks {
  final EnemyType enemyType;
  Enemy({required this.enemyType});

  static const int ySpawnPercent = 84;
  static Random _random = Random();

  EnemyState currentState = EnemyState.run;
  Vector2 groundForPlayer = Vector2.zero();

  RectangleHitbox enemyHitbox = RectangleHitbox(anchor: Anchor.topLeft);

  late final Map<EnemyState, SpriteAnimation> animations;

  @override
  FutureOr<void> onLoad() async {
    debugMode = true;

    animations = {
      EnemyState.run: await _createSpriteAnimation(
        enemyType.runSpriteImage,
        enemyType.runSpriteRow,
        enemyType.runSpriteColumns,
      ),
      EnemyState.hit: await _createSpriteAnimation(
        enemyType.hitSpriteImage,
        enemyType.hitSpriteRow,
        enemyType.hitSpriteColumns,
      ),
    };

    animation = animations[EnemyState.run];

    size = Vector2.all(90);
    anchor = Anchor.center;
    scale = Vector2.all(enemyType.scaleFactor);
    groundForPlayer.x = game.size.x + 100.0;
    setPosition();

    enemyHitbox.position = Vector2(enemyType.hitboxX, enemyType.hitboxY);
    enemyHitbox.size = Vector2(
      size.x - enemyType.hitboxWidthDiff,
      size.y - enemyType.hitboxHeightDiff,
    );
    add(enemyHitbox);
    /*
    add(RectangleHitbox());
    */

    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.x -= enemyType.xSpeed * dt;

    if (position.x < -25.0) {
      //position.x = game.size.x + 100.0;
      removeFromParent();
      game.scorer.addScore(1);
    }

    super.update(dt);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

    // relocate enemy to a favorable x,y
    setPosition();
  }

  void setPosition() {
    groundForPlayer.y = (ySpawnPercent * game.size.y) / 100;
    if (enemyType.canFly) {
      final double yUpOffset = -(_random.nextDoubleBetween(0, game.size.y / 3));
      final double yDownOffset = _random.nextDoubleBetween(0, size.y / 1.75);
      groundForPlayer.y += _random.nextBool() ? yUpOffset : yDownOffset;
    }
    position = groundForPlayer;
  }

  Future<SpriteAnimation> _createSpriteAnimation(
    String imagePath,
    int from,
    int to,
  ) async {
    final ui.Image spriteImg = await game.images.load(imagePath);
    final SpriteSheet spriteSheet = SpriteSheet(
      image: spriteImg,
      srcSize: Vector2(enemyType.textureX, enemyType.textureY),
    );
    return spriteSheet.createAnimation(
      row: 0,
      stepTime: 0.1,
      from: from,
      to: to,
    );
  }
}
