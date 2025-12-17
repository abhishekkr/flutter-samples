import 'package:flutter/material.dart';

class SettingsMenu extends StatelessWidget {
  final Function callOnBackPressed;
  const SettingsMenu({super.key, required this.callOnBackPressed});

  final double btnVerticalPad = 10;

  @override
  Widget build(BuildContext context) {
    final Widget titleText = Text(
      'SETTINGS',
      style: TextStyle(
        fontSize: 75,
        color: Colors.white,
        fontFamily: 'CrayonLibre',
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        titleText,
        SizedBox(height: btnVerticalPad),
        _buildSoundsButton(context),
        SizedBox(height: btnVerticalPad),
        _buildBackButton(context),
      ],
    );
  }

  Widget _buildSoundsButton(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 30,
          width: 250,
          child: SwitchListTile(
            value: true,
            title: Text(
              'Sounds:SFX',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontFamily: 'CrayonLibre',
              ),
            ),
            onChanged: (bool val) {},
          ),
        ),
        SizedBox(height: btnVerticalPad / 2),
        SizedBox(
          height: 30,
          width: 250,
          child: SwitchListTile(
            value: true,
            title: Text(
              'Sounds:BGM',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontFamily: 'CrayonLibre',
              ),
            ),
            onChanged: (bool val) {},
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        callOnBackPressed();
      },
      icon: Icon(Icons.arrow_back, color: Colors.white),
      iconSize: 30.0,
    );
  }
}
