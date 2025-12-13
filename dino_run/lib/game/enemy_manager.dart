import 'dart:async';
import 'dart:math' as dartMath;

import 'package:dino_run/game/mygame.dart';
import 'package:flame/components.dart';

import 'package:dino_run/game/enemy.dart';
import 'package:dino_run/game/enemy_type.dart';

class EnemyManager extends Component with HasGameReference<DinoRun> {
  final double interval;
  EnemyManager(this.interval);

  late final dartMath.Random _random;

  @override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad
    _random = dartMath.Random();
    //_timer = flameTimer.Timer(2, onTick: spawnEnemy, repeat: true);
    add(TimerComponent(period: interval, repeat: true, onTick: spawnEnemy));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }

  void spawnEnemy() {
    final enemyIndex = _random.nextInt(EnemyType.values.length);
    final newEnemy = Enemy(enemyType: EnemyType.values.elementAt(enemyIndex));
    game.add(newEnemy);
  }
}
