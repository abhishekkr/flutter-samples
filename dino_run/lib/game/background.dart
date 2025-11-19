import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/src/parallax.dart';

import 'package:dino_run/game/mygame.dart';

class LevelBackground extends ParallaxComponent<DinoRun> {
  final List<String> bgPaths = [
    "parallax_background/plx-1.png",
    "parallax_background/plx-2.png",
    "parallax_background/plx-3.png",
    "parallax_background/plx-4.png",
    "parallax_background/plx-5.png",
    "parallax_background/plx-6.png",
  ];

  @override
  FutureOr<void> onLoad() async {
    List<ParallaxImageData> parallaxImagesData = [];
    for (String bgPath in bgPaths) {
      parallaxImagesData.add(await ParallaxImageData(bgPath));
    }
    parallax = await game.loadParallax(
      parallaxImagesData,
      baseVelocity: Vector2(50, 0),
      velocityMultiplierDelta: Vector2(1.2, 0),
    );
    ;

    return super.onLoad();
  }
}
