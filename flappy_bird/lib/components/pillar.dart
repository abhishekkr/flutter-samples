import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/flapppy_bird_game.dart';
import 'package:flappy_bird/globalvars.dart';

class Pillar extends SpriteComponent
    with CollisionCallbacks, HasGameReference<FlapppyBirdGame> {
  final bool isTopPillar;
  Pillar(Vector2 pos, Vector2 syz, {required this.isTopPillar})
    : super(position: pos, size: syz);

  bool isScored = false;

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(
      isTopPillar ? pillarAboveSpriteFile : pillarBelowSpriteFile,
    );

    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.x -= groundScrollSpeed * dt;
    if (!isScored && (position.x + size.x) < game.player.position.x) {
      isScored = true;
    }
    if (position.x + size.x <= 0) {
      removeFromParent();
    }
    super.update(dt);
  }
}
