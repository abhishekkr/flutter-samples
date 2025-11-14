import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart';

import 'package:tiled_flame_game/src/level.dart';
import 'package:tiled_flame_game/src/playerold.dart';

class MyGame extends FlameGame with HasKeyboardHandlerComponents {
  MyGame();

  final zoomScale = 4.0;
  final tiledLevel01 = "level01";

  late Level level;
  late CameraComponent cam;
  late PlayerOld player;

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    player = PlayerOld();

    _loadLevel(tiledLevel01);

    return super.onLoad();
  }

  void reload() {
    removeAll(children);
    onLoad();
  }

  void _loadLevel(String levelName) {
    level = Level(levelName: levelName, player: player);

    final windowWidth = size.x;
    final windowHeight = size.y;
    final camX = (size.x - windowWidth) / zoomScale;
    final camY = (size.y - windowHeight) / zoomScale;
    print("============> size.x: ${size.x} | size.y: ${size.y}");
    print("============> camX: $camX | camY: $camY");

    cam = CameraComponent(
      world: level,
      viewport: FixedSizeViewport(windowWidth, windowHeight),
    );

    cam.viewfinder.anchor = Anchor.center;
    cam.viewfinder.zoom = zoomScale;
    cam.viewport.position = Vector2(camX, camY);
    cam.follow(player);

    addAll([cam, level]);
  }
}
