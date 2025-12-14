import 'package:dino_run/game/mygame.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  debugProfileBuildsEnabled = false; //true;
  debugProfileBuildsEnabledUserWidgets = false; //true;
  debugProfileLayoutsEnabled = false; //true;
  debugProfilePaintsEnabled = false; //true;
  debugProfilePlatformChannels = false; //true;

  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dino Run',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyGameWidget(title: 'Dino Run'),
    );
  }
}

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
          return IconButton(
            icon: Icon(Icons.pause, color: Colors.white, size: 30),
            onPressed: () {
              myGame.pauseEngine();
              myGame.overlays.add(myGame.pauseMenuOverlayId, priority: 1);
              myGame.overlays.remove(myGame.pauseOverlayId);
            },
          );
        },
        myGame.pauseMenuOverlayId: (BuildContext context, DinoRun game) {
          return IconButton(
            icon: Icon(Icons.play_arrow, color: Colors.white, size: 50),
            onPressed: () {
              myGame.resumeEngine();
              myGame.overlays.add(myGame.pauseOverlayId, priority: 1);
              myGame.overlays.remove(myGame.pauseMenuOverlayId);
            },
          );
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
