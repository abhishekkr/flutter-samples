import 'package:flutter/material.dart';

class WotwOpacity extends StatelessWidget {
  Widget build(BuildContext context) {
    final widgets = [
      Container(
        color: Colors.red,
        child: SizedBox(height: 390.0, width: 40.0),
      ),
      Opacity(
        opacity:0.0,
        child: Container(
          color: Colors.green,
          child: SizedBox(height: 390.0, width: 40.0),
        ),
      ),
      Container(
        color: Colors.blue,
        child: SizedBox(height: 390.0, width: 40.0),
      ),
      Expanded(
        child: Opacity(
          opacity:0.3,
          child: Container(
            color: Colors.teal,
            child: SizedBox(height: 390.0, width: 40.0),
          ),
        ),
      ),
    ];

    return Container (
      child: Row(
        children: widgets,
      ),
    );
  }
}
