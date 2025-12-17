import 'package:dino_run/home_menu.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => HomeMenu();
}
