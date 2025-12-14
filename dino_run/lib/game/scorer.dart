import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flame/components.dart';

import 'package:dino_run/game/mygame.dart';

class Scorer extends TextComponent with HasGameReference<DinoRun> {
  int score;
  int timerUpdateCounter;
  Scorer(this.score, {this.timerUpdateCounter = 2});

  @override
  FutureOr<void> onLoad() {
    text = score.toString();
    position = Vector2(game.size.x / 2, 50);
    textRenderer = TextPaint(
      style: TextStyle(
        fontSize: 32,
        color: Colors.yellowAccent,
        fontWeight: FontWeight.bold,
        fontFamily: 'CrayonLibre',
        fontStyle: FontStyle.normal,
      ),
    );
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

    // relocate enemy to a favorable x,y
    position = Vector2(game.size.x / 2, 50);
  }

  void addScore(int count) {
    score += count;
    text = score.toString();

    if (timerUpdateCounter > 0 && score % 11 == 0) {
      if (timerUpdateCounter > 1) {
        game.updateEnemyManagerB(2);
      } else {
        game.updateEnemyManagerA(2);
      }
      timerUpdateCounter -= 1;
    } else if (score % 100 == 0) {
      game.updateEnemyManagerB(0.5);
    } else if (score == 500) {
      game.addEnemyManager(2.5);
    }
  }

  int getScore() {
    return score;
  }

  void setScore(int val) {
    score = val;
    text = val.toString();
  }
}
