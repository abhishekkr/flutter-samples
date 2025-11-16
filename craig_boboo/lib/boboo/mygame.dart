import 'package:flutter/material.dart';

import 'package:craig_boboo/boboo/myapp.dart';

class MyGame extends StatelessWidget {
  const MyGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const Myapp(title: "Boboo"),
              ),
            );
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
