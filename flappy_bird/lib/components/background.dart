import 'dart:async';

import 'package:flame/components.dart';
import 'package:flappy_bird/globalvars.dart';

class Background extends SpriteComponent {
  Background(Vector2 bgPos, Vector2 bgSize)
    : super(position: bgPos, size: bgSize);

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(bgSpriteFile);
    return super.onLoad();
  }
}
