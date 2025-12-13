import 'dart:async';
import 'dart:math';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/components/background.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pillar_manager.dart';
import 'package:flappy_bird/components/pillar.dart';
import 'package:flappy_bird/components/player.dart';
import 'package:flappy_bird/components/score.dart';
import 'package:flappy_bird/globalvars.dart';
import 'package:flutter/material.dart';

class FlapppyBirdGame extends FlameGame
    with TapCallbacks, HasCollisionDetection {
  /*
    Basic Game Components:
    - player/bird
    - background
    - ground
    - pipes
    - score
    */

  late final Player player;
  late final Background background;
  late final Ground groundA;
  late final Ground groundB;
  late final PillarManager pillarManager;
  late final Score scoreDisplay;

  bool isGameOver = false;

  @override
  FutureOr<void> onLoad() {
    background = Background(bgPosition, size);
    add(background);

    groundA = Ground(
      Vector2(0, size.y - groundHeight),
      Vector2(size.x, groundHeight),
    );
    add(groundA);
    groundB = Ground(
      Vector2(size.x, size.y - groundHeight),
      Vector2(size.x, groundHeight),
    );
    add(groundB);

    pillarManager = PillarManager();
    add(pillarManager);

    scoreDisplay = Score(
      Vector2((size.x - scoreSize.x) / 2, (size.y - scoreSize.y) / 2),
      scoreSize,
    );
    add(scoreDisplay);

    player = Player(playerStartPosition, playerSpriteSize);
    add(player);

    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    player.goUp();
    super.onTapUp(event);
  }

  void gameOver() {
    if (isGameOver) {
      return;
    }
    isGameOver = true;
    scoreDisplay.changeScore(0);
    pauseEngine();
    showDialog(
      context: buildContext!,
      builder: (context) => AlertDialog(
        title: const Text("Game Over!"),
        content: Text("Score: ${gameScore.toString()}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              resetGame();
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    player.position = playerStartPosition;
    player.fallSpeed = 0;
    gameScore = 0;
    children.whereType<Pillar>().forEach((Pillar pillar) {
      pillar.removeFromParent();
    });
    isGameOver = false;
    resumeEngine();
  }
}
