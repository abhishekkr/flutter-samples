import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/events.dart';

class Ball extends BodyComponent with TapCallbacks {
  Ball({Vector2? initialPosition})
    : super(
        fixtureDefs: [
          FixtureDef(
            CircleShape()..radius = 5,
            restitution: 0.8,
            friction: 0.4,
          ),
        ],
        bodyDef: BodyDef(
          angularDamping: 0.8,
          position: initialPosition ?? Vector2.zero(),
          type: BodyType.dynamic,
        ),
      );

  @override
  void onTapDown(_) {
    body.applyLinearImpulse(Vector2.random() * 5000);
  }
}
