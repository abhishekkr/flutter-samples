import 'package:flutter/material.dart';

import 'package:craig_boboo/boboo/mygame.dart';

class Myapp extends StatelessWidget {
  const Myapp({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title, style: TextStyle(fontSize: 48)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'let the Boboo loose...',
              style: TextStyle(fontSize: 36),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (context) => const MyGame()),
                );
              },
              icon: Icon(Icons.play_circle, size: 120),
            ),
          ],
        ),
      ),
    );
  }
}
