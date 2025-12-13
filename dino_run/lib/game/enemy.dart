import 'dart:async';
import 'dart:ui' as ui;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import 'package:dino_run/game/mygame.dart';
import 'package:dino_run/game/enemy_type.dart';

enum EnemyState { run, hit }

class Enemy extends SpriteAnimationComponent
    with HasGameReference<DinoRun>, CollisionCallbacks {
  final EnemyType enemyType;
  Enemy({required this.enemyType});

  static const int ySpawnPercent = 84;

  EnemyState currentState = EnemyState.run;
  Vector2 groundForPlayer = Vector2.zero();

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
    groundForPlayer.y = (ySpawnPercent * game.size.y) / 100;
    position = groundForPlayer;

    /*
    RectangleHitbox rectHitbox = RectangleHitbox(
      position: position,
      size: Vector2(size.x - 10, size.y - 10),
    );
    add(rectHitbox);
    */
    add(RectangleHitbox());

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
    groundForPlayer.y = (ySpawnPercent * gameSize.y) / 100;
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
