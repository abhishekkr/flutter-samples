import 'dart:math' as math;
import 'package:flame/components.dart';

import 'package:forge2d_eg/my_forge2d_game.dart';

class Background extends SpriteComponent with HasGameReference<MyForge2dGame> {
  Background({required super.sprite})
    : super(anchor: Anchor.center, position: Vector2(0, 0));

  @override
  void onMount() {
    super.onMount();

    size = Vector2.all(
      math.max(
        game.camera.visibleWorldRect.width,
        game.camera.visibleWorldRect.height,
      ),
    );
  }
}
