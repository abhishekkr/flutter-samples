import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled_flame_game/src/collisions/collision_shape.dart';

import 'package:tiled_flame_game/src/my_game.dart';
import 'package:tiled_flame_game/src/playerold.dart';

class Level extends World with HasGameReference<MyGame> {
  final String levelName;
  final PlayerOld player;

  Level({required this.levelName, required this.player});

  late TiledComponent map;
  //late List<CollisionShape> collisionShapes = [];

  @override
  FutureOr<void> onLoad() async {
    map = await TiledComponent.load("$levelName.tmx", Vector2.all(16));

    add(map);
    _spawnObjects();
    _addCollisionShapes();
    print("pos.x: ${player.position.x} | size.x: ${player.size.x}");

    return super.onLoad();
  }

  void _spawnObjects() {
    final spawnPointsLayer = map.tileMap.getLayer<ObjectGroup>("Spawnpoints");
    if (spawnPointsLayer != null) {
      for (final spawnPoint in spawnPointsLayer.objects) {
        switch (spawnPoint.class_) {
          case "Player":
            player.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(player);
            print("[INFO] Added Player at ${player.position}.");
            break;
          default:
            print(
              "[WARNING] no handler for spawnPoint.class_: ${spawnPoint.id}, ${spawnPoint.name}, ${spawnPoint.type}, ${spawnPoint.gid}",
            );
            break;
        }
      }
    } else {
      print("[WARNING] Check spawnpoints.");
    }
  }

  void _addCollisionShapes() {
    final collisionShapesLayer = map.tileMap.getLayer<ObjectGroup>(
      "CollisionBlocks",
    );
    if (collisionShapesLayer != null) {
      for (final collisionShape in collisionShapesLayer.objects) {
        switch (collisionShape.class_) {
          case "CollisionBlocks":
            final block = CollisionShape(
              _extractPolygonPoints(collisionShape.polygon),
              position: Vector2(collisionShape.x, collisionShape.y),
            );
            add(block);
            // collisionShapes.add(block);
            print("[INFO] Added CollisionShape at ${block.position}.");
            print("${collisionShape.polygon}");
            break;
          default:
            print(
              "[WARNING] no handler for CollisionShape.class_: ${collisionShape.id}, ${collisionShape.name}, ${collisionShape.type}, ${collisionShape.gid}",
            );
            break;
        }
      }
    } else {
      print("[WARNING] Check CollisionBlocks.");
    }
  }

  List<Vector2> _extractPolygonPoints(List<Point>? polygonPoints) {
    return polygonPoints?.map((point) => Vector2(point.x, point.y)).toList() ??
        [];
  }
}
