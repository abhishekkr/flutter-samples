import 'dart:async';
import 'dart:ui';

import 'package:df_log/_common.dart';
import 'package:dino_run/game/enemy_manager.dart';
import 'package:dino_run/game/scorer.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
//import 'package:flame/events.dart';
import 'package:flame/input.dart';
//import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
//import 'package:flutter/widgets.dart';

import 'package:dino_run/game/actions/buttonJump.dart';
import 'package:dino_run/game/actions/joystick.dart';
import 'package:dino_run/game/player.dart';
import 'package:dino_run/game/enemy.dart';
import 'package:dino_run/game/enemy_type.dart';
import 'package:dino_run/game/background.dart';

class DinoRun extends FlameGame with KeyboardEvents, HasCollisionDetection {
  DinoRun();
  final String pauseOverlayId = 'PauseBtn';
  final String pauseMenuOverlayId = 'PausedMenu';
  final String healthOverlayId = 'HealthHearts';
  final String gameOverMenuOverlayId = 'GameOverMenu';

  late final Player dino;
  late final LevelBackground levelbg;
  late final GameJoystick joystick;
  late final ButtonJump btnJump;

  EnemyManager enemyManagerA = EnemyManager(4.0);
  EnemyManager enemyManagerB = EnemyManager(7.0);
  Scorer scorer = Scorer(0, timerUpdateCounter: 3);

  // Override Methods
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

    add(scorer);
    add(Enemy(enemyType: EnemyType.angrypig));
    add(enemyManagerA);
    add(enemyManagerB);

    overlays.add(pauseOverlayId);
    overlays.add(healthOverlayId);

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

  @override
  void update(double dt) {
    super.update(dt);
  }

  //Custom Methods
  void reload() {
    removeAll(children);
    onLoad();
  }

  void resetLevel() {
    children.whereType<Enemy>().forEach((Enemy child) {
      child.removeFromParent();
    });
    enemyManagerA.removeFromParent();
    enemyManagerB.removeFromParent();
    enemyManagerA = EnemyManager(4.0);
    add(enemyManagerA);
    enemyManagerB = EnemyManager(7.0);
    add(enemyManagerB);
    dino.healthHearts = ValueNotifier(5);
    scorer.setScore(0);
  }

  void updateEnemyManagerA(double intervalReduction) {
    final newInterval = enemyManagerA.interval - intervalReduction;
    if (newInterval <= 1) {
      Log.ok("EnemyManager spawn duration can't be lowered to ${newInterval}.");
    }
    enemyManagerA.removeFromParent();
    enemyManagerA = EnemyManager(newInterval);
    add(enemyManagerA);
  }

  void updateEnemyManagerB(double intervalReduction) {
    final newInterval = enemyManagerB.interval - intervalReduction;
    if (newInterval <= 1) {
      Log.ok("EnemyManager spawn duration can't be lowered to ${newInterval}.");
    }
    enemyManagerB.removeFromParent();
    enemyManagerB = EnemyManager(newInterval);
    add(enemyManagerB);
  }

  void addEnemyManager(double interval) {
    if (interval <= 1.0) {
      Log.ok("EnemyManager spawn duration can't be lowered to ${interval}.");
    }
    add(EnemyManager(interval));
  }
}
