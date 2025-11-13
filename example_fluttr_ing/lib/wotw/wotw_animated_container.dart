import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';

class WotwAnimatedContainer extends StatefulWidget {
  @override
  _WotwAnimatedContainerAppState createState() => _WotwAnimatedContainerAppState();
}

class _WotwAnimatedContainerAppState extends State<WotwAnimatedContainer> {
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: new EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AnimatedContainer(
            // Use the properties stored in the State class.
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: _borderRadius,
            ),
            duration: Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
          ), // <AnimatedContainer/>
          SizedBox(height: 50.0, width: 50.0),
          FloatingActionButton(
            child: Icon(Icons.play_arrow),
            // When the user taps the button
            onPressed: () {
              // Use setState to rebuild the widget with new values.
              setState(() {
                // Create a random number generator.
                final random = Random();

                // Generate a random width and height.
                _width = random.nextInt(300).toDouble();
                _height = random.nextInt(300).toDouble();

                // Generate a random color.
                _color = Color.fromRGBO(
                  random.nextInt(256),
                  random.nextInt(256),
                  random.nextInt(256),
                  1,
                );

                // Generate a random border radius.
                _borderRadius =
                    BorderRadius.circular(random.nextInt(100).toDouble());
              });
            },
          ), // <FloatingActionButton/>
        ],
      ), // <Column/>
    ); // <Center/>
  }
}
