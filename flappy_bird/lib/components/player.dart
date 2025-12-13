import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pillar.dart';
import 'package:flappy_bird/flapppy_bird_game.dart';
import 'package:flappy_bird/globalvars.dart';

class Player extends SpriteComponent with CollisionCallbacks {
  Player(Vector2 myPos, Vector2 mySize) : super(position: myPos, size: mySize);

  double fallSpeed = 0;
  final double jumpStrength = -300;

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(playerSpriteFile);

    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    fallSpeed += worldGravity;
    position.y = fallSpeed * dt; // distance = speed x time
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Ground) {
      print("Player Collided with Ground.");
      (parent as FlapppyBirdGame).gameOver();
    } else if (other is Pillar) {
      (parent as FlapppyBirdGame).gameOver();
    }
    super.onCollision(intersectionPoints, other);
  }

  void goUp() {
    fallSpeed = jumpStrength;
  }
}
