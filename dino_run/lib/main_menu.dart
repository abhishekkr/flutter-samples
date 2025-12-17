import 'package:dino_run/game/audio_manager.dart';
import 'package:dino_run/my_game_widget.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  final Function callOnSettingsPressed;
  const MainMenu({super.key, required this.callOnSettingsPressed});

  final double btnVerticalPad = 10;

  @override
  Widget build(BuildContext context) {
    final Widget titleText = Text(
      'DINO RUN',
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
        _buildPlayButton(context),
        SizedBox(height: btnVerticalPad / 2),
        _buildSettingsButton(context),
      ],
    );
  }

  Widget _buildPlayButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.greenAccent,
        padding: EdgeInsets.symmetric(horizontal: 95, vertical: btnVerticalPad),
      ),
      onHover: (isHovering) {
        if (isHovering) {
          AudioManager.instance.sfxPlay('event');
        }
      },
      onPressed: () {
        AudioManager.instance.sfxPlay('event');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MyGameWidget(title: 'DINO RUN'),
          ),
        );
      },
      child: Text(
        'PLAY',
        style: TextStyle(
          fontSize: 50,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'CrayonLibre',
        ),
      ),
    );
  }

  Widget _buildSettingsButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.greenAccent,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: btnVerticalPad),
      ),
      onHover: (isHovering) {
        if (isHovering) {
          AudioManager.instance.sfxPlay('event');
        }
      },
      onPressed: () {
        AudioManager.instance.sfxPlay('event');
        callOnSettingsPressed();
      },
      child: Text(
        'SETTINGS',
        style: TextStyle(
          fontSize: 50,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'CrayonLibre',
        ),
      ),
    );
  }
}
