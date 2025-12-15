import 'package:dino_run/game/mygame.dart';
import 'package:dino_run/game/overlays.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class MyGameWidget extends StatefulWidget {
  const MyGameWidget({super.key, required this.title});
  final String title;

  @override
  State<MyGameWidget> createState() => _MyGameWidgetState();
}

class _MyGameWidgetState extends State<MyGameWidget> {
  final DinoRun myGame = DinoRun();

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: myGame,
      overlayBuilderMap: {
        myGame.pauseOverlayId: (BuildContext context, DinoRun game) {
          return buildPauseOverlay(myGame);
        },
        myGame.pauseMenuOverlayId: (BuildContext context, DinoRun game) {
          return buildPauseMenuOverlay(context, myGame);
        },
        myGame.healthOverlayId: (BuildContext context, DinoRun game) {
          return buildHealthOverlay(context, myGame);
        },
        myGame.gameOverMenuOverlayId: (BuildContext context, DinoRun game) {
          return buildGameOverMenuOverlay(context, myGame);
        },
      },
    );
  }

  @override
  void reassemble() {
    super.reassemble();
    myGame.reload();
  }
}
