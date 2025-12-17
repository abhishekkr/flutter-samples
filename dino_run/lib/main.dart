import 'dart:io';

import 'package:dino_run/game/audio_manager.dart';
import 'package:dino_run/home_menu.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  debugProfileBuildsEnabled = false; //true;
  debugProfileBuildsEnabledUserWidgets = false; //true;
  debugProfileLayoutsEnabled = false; //true;
  debugProfilePaintsEnabled = false; //true;
  debugProfilePlatformChannels = false; //true;

  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  final Directory appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  await AudioManager.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => HomeMenu();
}
