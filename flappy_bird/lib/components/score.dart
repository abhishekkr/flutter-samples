import 'dart:async';

import 'package:flame/components.dart';
import 'package:flappy_bird/globalvars.dart';

class Score extends TextComponent {
  Score(Vector2 pos, Vector2 syz) : super(position: pos, size: syz);

  @override
  FutureOr<void> onLoad() {
    text = gameScore.toString();
    return super.onLoad();
  }

  void increaseBy(int val) {
    changeScore(gameScore + val);
  }

  void changeScore(int val) {
    if (gameScore == val) {
      return;
    }
    gameScore = val;
    final newScoreTxt = gameScore.toString();
    text = newScoreTxt;
  }
}
