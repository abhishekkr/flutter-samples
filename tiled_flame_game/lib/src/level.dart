import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

import 'package:tiled_flame_game/src/my_game.dart';
import 'package:tiled_flame_game/src/playerold.dart';


class Level extends World with HasGameRef<MyGame> {
  final String levelName;
  final PlayerOld player;

  Level({required this.levelName, required this.player});

  late TiledComponent map;

  @override
  FutureOr<void> onLoad() async {
    map = await TiledComponent.load("$levelName.tmx", Vector2.all(16));

    add(map);
    _spawnObjects();
    print("pos.x: ${player.position.x} | size.x: ${player.size.x}");

    return super.onLoad();
  }


  void _spawnObjects() {
    final spawnPointsLayer = map.tileMap.getLayer<ObjectGroup>("Spawnpoints");
    if (spawnPointsLayer != null) {
      for (final spawnPoint in spawnPointsLayer.objects) {
        switch (spawnPoint.class_) {
          case "Player":
            //player.size = Vector2(16, 16);
            player.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(player);
            print("[INFO] Added Player at ${player.position}.");
            break;
          default:
            print("[WARNING] no handler for spawnPoint.class_: ${spawnPoint.id}, ${spawnPoint.name}, ${spawnPoint.type}, ${spawnPoint.gid}");
            break;
        }
      }
    } else {
      print("[WARNING] Check spawnpoints.");
      player.position = Vector2(450, 450);
      player.size = Vector2(16, 16);
      //player.position = Vector2(0, 0);
      add(player);
    }
  }
}
