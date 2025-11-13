import 'package:flutter/material.dart';

class WotwSafeArea extends StatelessWidget {
  Widget build(BuildContext context) {
    return SafeArea (
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: ListView(
            children: List.generate(
                100,
                (idx) => Text("something at #" + idx.toString()),
            )
        )
    );
  }
}
