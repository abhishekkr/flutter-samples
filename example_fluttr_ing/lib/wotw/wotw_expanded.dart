import 'package:flutter/material.dart';

class WotwExpanded extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container (
        alignment: Alignment.center,
        child: Row(
            children: <Widget>[
              Container(
                color: Colors.red,
                child: SizedBox(height: 390.0, width: 40.0),
              ),
              Expanded(
                flex: 2,
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
                flex: 1,
                child: Container(
                  color: Colors.teal,
                  child: SizedBox(height: 390.0, width: 40.0),
                ),
              ),
            ],
      ),
    );
  }
}
