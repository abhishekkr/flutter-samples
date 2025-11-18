import 'dart:async';

import 'package:flutter/widgets.dart' show EdgeInsets;
import 'package:flame/components.dart';
import 'package:flame/palette.dart';

class GameJoystick extends JoystickComponent {
  GameJoystick()
    : super(
        knob: CircleComponent(
          radius: 30,
          paint: BasicPalette.red.withAlpha(159).paint(),
        ),
        margin: const EdgeInsets.only(left: 20, bottom: 20),
        background: CircleComponent(
          radius: 90,
          paint: BasicPalette.gray.withAlpha(90).paint(),
        ),
      );

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    return super.onLoad();
  }
}
