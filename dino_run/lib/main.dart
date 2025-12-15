import 'package:dino_run/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
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
      home: const MainMenu(),
    );
  }
}
