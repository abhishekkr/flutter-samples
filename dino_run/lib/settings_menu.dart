import 'package:dino_run/game/audio_manager.dart';
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
    final TextStyle txtStyle = TextStyle(
      fontSize: 25,
      color: Colors.white,
      fontFamily: 'CrayonLibre',
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 30,
          width: 250,
          child: ValueListenableBuilder(
            valueListenable: AudioManager.instance.listenableBGM,
            builder: (BuildContext ctx, bool val, Widget? child) {
              return SwitchListTile(
                value: val,
                title: Text('Sounds:BGM', style: txtStyle),
                onChanged: (bool val) {
                  AudioManager.instance.setBGM(val);
                },
              );
            },
          ),
        ),
        SizedBox(height: btnVerticalPad / 2),
        SizedBox(
          height: 30,
          width: 250,
          child: ValueListenableBuilder(
            valueListenable: AudioManager.instance.listenableSFX,
            builder: (BuildContext ctx, bool val, Widget? child) {
              return SwitchListTile(
                value: val,
                title: Text('Sounds:SFX', style: txtStyle),
                onChanged: (bool val) {
                  AudioManager.instance.setSFX(val);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      onHover: (isHovering) {
        if (isHovering) {
          AudioManager.instance.sfxPlay('event');
        }
      },
      onPressed: () {
        AudioManager.instance.sfxPlay('event');
        callOnBackPressed();
      },
      icon: Icon(Icons.arrow_back, color: Colors.white),
      iconSize: 30.0,
    );
  }
}
