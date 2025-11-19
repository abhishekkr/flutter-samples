import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

import 'package:dino_run/game/mygame.dart';

class ButtonJump extends SpriteButtonComponent with HasGameReference<DinoRun> {
  final Function() onTap;
  final Vector2 btnSize;
  final double btnAngle;

  ButtonJump({
    required this.onTap,
    required this.btnSize,
    required this.btnAngle,
  });

  @override
  Future<void> onLoad() async {
    final imgJmpInactive = await game.images.load(
      'gui/yellow_button_gloss.png',
    );
    final imgJmpActive = await game.images.load(
      'gui/yellow_button_gradient.png',
    );

    button = Sprite(imgJmpInactive);
    buttonDown = Sprite(imgJmpActive);
    onPressed = onTap;
    size = btnSize;
    angle = btnAngle;
    anchor = Anchor.center;

    final label = TextComponent(
      text: 'JUMP',
      scale: scale / 1.25,
      anchor: Anchor.topCenter,
      position: Vector2(btnSize.x / 2, 5),
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: btnSize.x / 2.5,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(label);

    return super.onLoad();
  }

  Vector2 newPosition() {
    double yOffset = 100.0;
    if (game.size.y > 200) {
      yOffset = (15 * game.size.y) / 100; // 15% from bottom
    } else {
      yOffset = (10 * game.size.y) / 100; // 10% from bottom
    }
    return Vector2(game.size.x - 50, yOffset);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    position = newPosition();
  }
}
