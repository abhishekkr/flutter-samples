import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/globalvars.dart';

class Ground extends SpriteComponent with CollisionCallbacks {
  Ground(Vector2 gPos, Vector2 gSize) : super(position: gPos, size: gSize);

  @override
  FutureOr<void> onLoad() async {
    double heightRatio = (groundHeight / groundOriginalSize.y) * 100;
    double adjustedWidth = (groundOriginalSize.x * heightRatio) / 100;
    size.x = adjustedWidth + groundOverlap; // to allow reset of ground scroll

    sprite = await Sprite.load(groundSpriteFile);

    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.x -= groundScrollSpeed * dt;
    if (position.x + size.x - groundOverlap <= 0) {
      position.x = size.x;
    }
    super.update(dt);
  }
}
