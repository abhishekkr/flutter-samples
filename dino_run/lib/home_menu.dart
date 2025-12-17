import 'package:dino_run/game/audio_manager.dart';
import 'package:dino_run/main.dart';
import 'package:dino_run/settings_menu.dart';
import 'package:dino_run/main_menu.dart';
import 'package:flutter/material.dart';

class HomeMenu extends State<MyApp> {
  late ValueNotifier<CrossFadeState> _crossFadeStateNotifier;

  @override
  void initState() {
    _crossFadeStateNotifier = ValueNotifier(CrossFadeState.showFirst);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dino Run',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _buildMenu(context),
    );
  }

  @override
  Widget _buildMenu(BuildContext context) {
    final Widget menuPanel = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/main_menu_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Colors.greenAccent.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 25.0),
            child: ValueListenableBuilder(
              valueListenable: _crossFadeStateNotifier,
              builder: (BuildContext ctx, CrossFadeState val, Widget? child) {
                return AnimatedCrossFade(
                  crossFadeState: val,
                  duration: Duration(milliseconds: 200),
                  firstChild: MainMenu(callOnSettingsPressed: showSettingsMenu),
                  secondChild: SettingsMenu(callOnBackPressed: showMainMenu),
                );
              },
            ),
          ),
        ),
      ),
    );

    return Scaffold(body: menuPanel);
  }

  void showMainMenu() {
    AudioManager.instance.sfxPlay('event');
    _crossFadeStateNotifier.value = CrossFadeState.showFirst;
  }

  void showSettingsMenu() {
    AudioManager.instance.sfxPlay('event');
    _crossFadeStateNotifier.value = CrossFadeState.showSecond;
  }
}
