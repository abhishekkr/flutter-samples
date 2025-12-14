import 'dart:async';

import 'package:df_log/_common.dart';
import 'package:dino_run/game/enemy.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import 'package:dino_run/game/mygame.dart';

enum PlayerState { idle, run, kick, hit, sprint }

class Player extends SpriteAnimationComponent
    with HasGameReference<DinoRun>, CollisionCallbacks {
  static const String spritePath = "DinoSprites_doux.png";
  static const double speed = 3.0;
  static const int xSpawnPercent = 15;
  static const int ySpawnPercent = 84;
  static const int jumpHeightPercent = 20;
  static const int jumpHeightPercentLow = 15;
  double jumpHeight = 150.0;
  bool jumpState = false;
  bool hitState = false;
  double hitStateInterval = 2;

  PlayerState currentState = PlayerState.idle;
  ValueNotifier<int> healthHearts = ValueNotifier(5);

  Vector2 groundForPlayer = Vector2.zero();

  late final Map<PlayerState, SpriteAnimation> animations;

  @override
  FutureOr<void> onLoad() async {
    debugMode = true;

    final spriteImage = await game.images.load("DinoSprites_doux.png");
    final spriteSheet = SpriteSheet(
      image: spriteImage,
      srcSize: Vector2.all(24),
    );

    animations = {
      PlayerState.idle: _createSpriteAnimation(spriteSheet, 0, 0, 3),
      PlayerState.run: _createSpriteAnimation(spriteSheet, 0, 4, 10),
      PlayerState.kick: _createSpriteAnimation(spriteSheet, 0, 11, 13),
      PlayerState.hit: _createSpriteAnimation(spriteSheet, 0, 14, 16),
      PlayerState.sprint: _createSpriteAnimation(spriteSheet, 0, 17, 23),
    };

    animateRun();

    size = Vector2.all(90);
    anchor = Anchor.center;

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
    super.update(dt);

    if (hitState) {
      animateHit();
    } else if (game.joystick.direction != JoystickDirection.idle) {
      doMovePlayer(dt);
    }
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

    double newJumpHeight;
    if (game.size.y > 400) {
      newJumpHeight = (jumpHeightPercent * gameSize.x) / 100;
    } else {
      newJumpHeight = (jumpHeightPercentLow * gameSize.x) / 100;
    }
    if (newJumpHeight > jumpHeight) {
      jumpHeight = newJumpHeight;
    }

    // relocate player to a favorable x,y
    groundForPlayer.x = (xSpawnPercent * gameSize.x) / 100;
    groundForPlayer.y = (ySpawnPercent * gameSize.y) / 100;
    Log.info("game.size: $gameSize | player.size: $size");
    Log.info("groundForPlayer: $groundForPlayer");
    position = groundForPlayer;
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is ScreenHitbox) {
      Log.ok("Player at Screen Edge.");
    } else if (other is Enemy) {
      Log.ok("Player hit by Enemy.");
      enableHitState(currentState, hitStateInterval);
    }
    super.onCollision(points, other);
  }

  void enableHitState(PlayerState prevState, double period) {
    if (hitState) {
      return;
    }
    final TimerComponent hitTimer = TimerComponent(
      period: period,
      autoStart: true,
      repeat: false,
      removeOnFinish: true,
      onTick: () {
        hitState = false;
        currentState = prevState;
        animation = animations[prevState];
      },
    );
    add(hitTimer);
    healthHearts.value -= 1;
    hitState = true;
  }

  SpriteAnimation _createSpriteAnimation(
    SpriteSheet spriteSheet,
    int row,
    int from,
    int to,
  ) {
    return spriteSheet.createAnimation(
      row: row,
      stepTime: 0.1,
      from: from,
      to: to,
    );
  }

  void doMovePlayer(double dt) {
    // this should only allow left or right
    final maxScreenX = game.size.x - size.x;
    var pos = Vector2(x, y);
    if (game.joystick.delta.x != 0) {
      pos.x += speed * game.joystick.delta.x * dt;
      if (game.joystick.delta.x < 0) {
        scale.x = -1;
      } else if (game.joystick.delta.x > 0) {
        scale.x = 1;
      }
    }
    position = Vector2(pos.x.clamp(0, maxScreenX), pos.y.clamp(0, game.size.y));
    animateSprint();
  }

  void animateIdle() {
    currentState = PlayerState.idle;
    animation = animations[PlayerState.idle];
  }

  void animateRun() {
    currentState = PlayerState.run;
    animation = animations[PlayerState.run];
  }

  void animateKick() {
    currentState = PlayerState.kick;
    animation = animations[PlayerState.kick];
  }

  void animateHit() {
    currentState = PlayerState.hit;
    animation = animations[PlayerState.hit];
  }

  void animateSprint() {
    currentState = PlayerState.sprint;
    animation = animations[PlayerState.sprint];
  }

  void groundIt() {
    position.y = groundForPlayer.y;
    if (currentState == PlayerState.idle) {
      animateRun();
    }
    jumpState = false;
  }

  void handleJoystickDragStop() {
    if (currentState == PlayerState.sprint) {
      animateRun();
    }
  }

  void doJump() {
    if (jumpState) {
      return;
    }
    jumpState = true;
    if (currentState == PlayerState.run) {
      animateIdle();
    }
    final effect = MoveByEffect(
      Vector2(25, -jumpHeight),
      EffectController(
        duration: 0.75,
        reverseDuration: 0.5,
        infinite: false,
        curve: Curves.easeInOutCirc,
      ),
      onComplete: groundIt,
    );
    add(effect);
  }
}
