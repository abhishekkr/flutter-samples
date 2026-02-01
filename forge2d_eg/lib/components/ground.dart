import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

const groundSize = 7.0;

class Ground extends BodyComponent {
  final Vector2 xy;
  final Sprite sprite;

  Ground(this.xy, this.sprite)
    : super(
        renderBody: false,
        bodyDef: BodyDef()
          ..position = xy
          ..type = BodyType.static,
        fixtureDefs: [
          FixtureDef(
            PolygonShape()..setAsBoxXY(groundSize / 2, groundSize / 2),
            friction: 0.3,
          ),
        ],
        children: [
          SpriteComponent(
            sprite: sprite,
            anchor: Anchor.center,
            size: Vector2.all(groundSize),
            position: Vector2.zero(),
          ),
        ],
      );
}
