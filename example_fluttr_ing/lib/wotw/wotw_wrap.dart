import 'package:flutter/material.dart';

class WotwWrap extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container (
        alignment: Alignment.center,
        child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.end,
            spacing: 15.0,
            runSpacing: 50.0,
            children: <Widget>[
              Container(
                color: Colors.red,
                child: SizedBox(height: 190.0, width: 40.0),
              ),
              Container(
                color: Colors.green,
                child: SizedBox(height: 190.0, width: 40.0),
              ),
              Container(
                color: Colors.blue,
                child: SizedBox(height: 190.0, width: 40.0),
              ),
              Container(
                color: Colors.teal,
                child: SizedBox(height: 190.0, width: 40.0),
              ),
            ],
      ),
    );
  }
}
