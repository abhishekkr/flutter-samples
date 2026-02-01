import 'dart:async';
import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forge2d_eg/components/background.dart';
import 'package:forge2d_eg/components/brick.dart';
import 'package:forge2d_eg/components/enemy.dart';
import 'package:forge2d_eg/components/ground.dart';
import 'package:forge2d_eg/components/player.dart';

import 'package:forge2d_eg/components/wall.dart';
import 'package:forge2d_eg/components/ball.dart';
import 'package:forge2d_eg/components/xml_spritesheet.dart';

class MyForge2dGame extends Forge2DGame {
  MyForge2dGame() : super(gravity: Vector2(0, 10));
  // Can have fixed res camera with~
  // camera: CameraComponent.withFixedResolution(width:800, height: 600),

  late final XmlSpriteSheet aliens;
  final aliensXmlFile = 'assets/images/spritesheet_aliens.xml';
  late final XmlSpriteSheet elements;
  final elementsXmlFile = 'assets/images/spritesheet_elements.xml';
  late final XmlSpriteSheet tiles;
  final tilesXmlFile = 'assets/images/spritesheet_tiles.xml';
  final _random = math.Random();

  var enemiesFullyAdded = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await loadImages();
    await loadXmlSpriteSheets();

    world.addAll(createBoundaries());
    await addGround();

    camera.viewport.add(FpsTextComponent());
    world.add(Ball());
    //unawaited(addBricks());
    unawaited(addBricks().then((_) => addEnemies()));
    await addPlayer();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isMounted &&
        world.children.whereType<Player>().isEmpty &&
        world.children.whereType<Enemy>().isNotEmpty) {
      addPlayer();
    }
    if (isMounted &&
        enemiesFullyAdded &&
        world.children.whereType<Enemy>().isEmpty &&
        world.children.whereType<TextComponent>().isEmpty) {
      world.addAll(
        [
          (position: Vector2(0.5, 0.5), color: Colors.white),
          (position: Vector2.zero(), color: Colors.orangeAccent),
        ].map(
          (e) => TextComponent(
            text: 'You win!',
            anchor: Anchor.center,
            position: e.position,
            textRenderer: TextPaint(
              style: TextStyle(color: e.color, fontSize: 16),
            ),
          ),
        ),
      );
    }
  }

  List<Component> createBoundaries() {
    final visibleRect = camera.visibleWorldRect;
    final topLeft = visibleRect.topLeft.toVector2();
    final topRight = visibleRect.topRight.toVector2();
    final bottomRight = visibleRect.bottomRight.toVector2();
    final bottomLeft = visibleRect.bottomLeft.toVector2();

    return [
      Wall(topLeft, topRight), // ceiling
      Wall(topRight, bottomRight), // right wall
      Wall(topLeft, bottomLeft), // left wall
      Wall(bottomLeft, bottomRight), // floor
    ];
  }

  Future<void> loadImages() async {
    final bgImg = await images.load('colored_desert.png');
    //images.load('colored_grass.png'),
    //images.load('colored_land.png'),
    //images.load('colored_shroom.png'),
    await world.add(Background(sprite: Sprite(bgImg)));
  }

  Future<void> loadXmlSpriteSheets() async {
    final [aliensImg, elementsImg, tilesImg] = await [
      images.load('spritesheet_aliens.png'),
      images.load('spritesheet_elements.png'),
      images.load('spritesheet_tiles.png'),
    ].wait;

    aliens = XmlSpriteSheet(
      aliensImg,
      await rootBundle.loadString(aliensXmlFile),
    );
    elements = XmlSpriteSheet(
      elementsImg,
      await rootBundle.loadString(elementsXmlFile),
    );
    tiles = XmlSpriteSheet(tilesImg, await rootBundle.loadString(tilesXmlFile));
    print('tiles init');
  }

  Future<void> addGround() {
    return world.addAll([
      for (
        var x = camera.visibleWorldRect.left;
        x < camera.visibleWorldRect.right + groundSize;
        x += groundSize
      )
        Ground(
          Vector2(x, (camera.visibleWorldRect.height - groundSize) / 2),
          tiles.getSprite('grass.png'),
        ),
    ]);
  }

  Future<void> addBricks() async {
    for (var idx = 0; idx < brickCount; idx++) {
      final brickType = BrickType.randomType;
      final brickSize = BrickSize.randomSize;
      final brickX =
          camera.visibleWorldRect.right / 3 + (_random.nextDouble() * 5 - 2.5);
      final brick = Brick(
        brickType: brickType,
        brickSize: brickSize,
        damage: BrickDamage.some,
        position: Vector2(brickX, 0),
        sprites: brickFileNames(
          brickType,
          brickSize,
        ).map((key, filename) => MapEntry(key, elements.getSprite(filename))),
      );
      await world.add(brick);
      await Future<void>.delayed(const Duration(milliseconds: 500));
    }
  }

  Future<void> addPlayer() async => world.add(
    Player(
      Vector2(camera.visibleWorldRect.left * 2 / 3, 0),
      aliens.getSprite(PlayerColor.randomColor.fileName),
    ),
  );

  Future<void> addEnemies() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    for (var i = 0; i < 3; i++) {
      await world.add(
        Enemy(
          Vector2(
            camera.visibleWorldRect.right / 3 +
                (_random.nextDouble() * 7 - 3.5),
            (_random.nextDouble() * 3),
          ),
          aliens.getSprite(EnemyColor.randomColor.fileName),
        ),
      );
      await Future<void>.delayed(const Duration(seconds: 1));
    }
    enemiesFullyAdded = true;
  }
}
