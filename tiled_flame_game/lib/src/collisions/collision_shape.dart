import 'package:flame/components.dart';

class CollisionShape extends PolygonComponent {
  CollisionShape(super.relation, {super.position}) {
    debugMode = true;
  }
}
