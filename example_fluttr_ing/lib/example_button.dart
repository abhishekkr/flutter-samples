import 'package:flutter/material.dart';

class ExampleButton extends StatelessWidget {
  final String label;
  final Function onClickFn;
  ExampleButton({super.key, required this.label, required this.onClickFn});
  final txtStyle = TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 200.0,
      height: 40.0,
      child: ElevatedButton(
        child: Text(label, style: txtStyle),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          backgroundColor: Colors.white, // Background color
          foregroundColor: Colors.amber, // Text color
        ),
        onPressed: () {
          onClickFn();
        },
      ),
    );
  }
}
