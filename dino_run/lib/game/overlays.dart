import 'package:dino_run/game/mygame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget buildPauseOverlay(DinoRun myGame) {
  return IconButton(
    icon: Icon(Icons.pause, color: Colors.white, size: 30),
    onPressed: () {
      myGame.pauseEngine();
      myGame.overlays.add(myGame.pauseMenuOverlayId, priority: 1);
      myGame.overlays.remove(myGame.pauseOverlayId);
    },
  );
}

Widget buildPauseMenuOverlay(BuildContext context, DinoRun myGame) {
  return Center(
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(15.0),
      ),
      color: Colors.black.withOpacity(0.25),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'PAUSED',
              style: TextStyle(fontSize: 75.0, color: Colors.yellowAccent),
            ),
            IconButton(
              icon: Icon(Icons.play_arrow, color: Colors.white, size: 50),
              onPressed: () {
                myGame.resumeEngine();
                myGame.overlays.add(myGame.pauseOverlayId, priority: 1);
                myGame.overlays.remove(myGame.pauseMenuOverlayId);
              },
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildHealthOverlay(BuildContext context, DinoRun myGame) {
  return ValueListenableBuilder(
    valueListenable: myGame.dino.healthHearts,
    builder: (BuildContext context, int value, Widget? child) {
      final List<Widget> list = List<Widget>.generate(
        5,
        (i) => i < value
            ? Icon(Icons.favorite, color: Colors.red, size: 30.0)
            : Icon(Icons.favorite_border, color: Colors.red, size: 30.0),
      );
      // return Row(mainAxisAlignment: MainAxisAlignment.end, children: list);
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            child: Row(children: list),
          ),
        ],
      );
    },
  );
}

Widget buildGameOverMenuOverlay(BuildContext context, DinoRun myGame) {
  myGame.pauseEngine();
  return Center(
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(15.0),
      ),
      color: Colors.black.withOpacity(0.5),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'GAME OVER',
              style: TextStyle(fontSize: 75.0, color: Colors.yellowAccent),
            ),
            Text(
              'You Scored: ${myGame.scorer.score.toString()}',
              style: TextStyle(fontSize: 75.0, color: Colors.yellowAccent),
            ),
            IconButton(
              icon: Icon(Icons.replay, color: Colors.white, size: 50),
              onPressed: () {
                myGame.resetLevel();
                myGame.resumeEngine();
                myGame.overlays.remove(myGame.gameOverMenuOverlayId);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
