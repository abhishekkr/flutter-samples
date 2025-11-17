import 'package:flutter/material.dart';
import 'package:flame/flame.dart';

import 'package:craig_boboo/boboo/myapp.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  runApp(const MyScreen());
}

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boboo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Myapp(title: "Craig's Boboo"),
    );
  }
}
