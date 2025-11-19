import 'dart:async';

import 'package:flutter/widgets.dart' show EdgeInsets;
import 'package:flame/components.dart';
import 'package:flame/palette.dart';

class GameJoystick extends JoystickComponent {
  final Function() onIdle;
  final double bigRadius;
  GameJoystick({required this.onIdle, required this.bigRadius})
    : super(
        knob: CircleComponent(
          radius: bigRadius / 3,
          paint: BasicPalette.red.withAlpha(159).paint(),
        ),
        margin: const EdgeInsets.only(left: 20, bottom: 20),
        background: CircleComponent(
          radius: bigRadius,
          paint: BasicPalette.gray.withAlpha(90).paint(),
        ),
      );

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    return super.onLoad();
  }

  Vector2 newPosition() {
    double xOffset = 50.0;
    double yOffset = 50.0;
    if (game.size.y > 200) {
      yOffset = (5 * game.size.y) / 100; // 5% from bottom
    } else {
      xOffset = (2 * game.size.x) / 100; // 2% from left
      yOffset = game.size.y / 100; // 1% from bottom
    }
    return Vector2(bigRadius + xOffset, bigRadius + yOffset);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    position = newPosition();
  }

  @override
  void onDragStop() {
    onIdle();
    super.onDragStop();
  }
}
