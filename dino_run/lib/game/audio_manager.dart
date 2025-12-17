import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_ce/hive.dart';

class AudioManager {
  AudioManager._internal();

  static AudioManager _instance = AudioManager._internal();

  static AudioManager get instance => _instance;

  final String hiveBoxName = 'dino_run_game_settings';
  final Map<String, String> filePath = {
    'bgm': 'abionic-game-sounds-kalimba-2dot5.wav',
    'event': 'abionic-game-sounds-event.wav',
    'playerHurt': 'abionic-game-sounds-got-hurt.wav',
    'playerJump': 'hunteraudio-8bit-sfx-Jump2.wav',
  };

  Future init() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll(filePath.values.toList());

    _settings = await Hive.openBox(hiveBoxName);
    if (_settings.get('bgm') == null) {
      _settings.put('bgm', true);
    }
    if (_settings.get('sfx') == null) {
      _settings.put('sfx', true);
    }

    _bgm = ValueNotifier(_settings.get('bgm'));
    _sfx = ValueNotifier(_settings.get('sfx'));
  }

  late Box _settings;
  late ValueNotifier<bool> _bgm;
  late ValueNotifier<bool> _sfx;

  ValueNotifier<bool> get listenableBGM => _bgm;
  ValueNotifier<bool> get listenableSFX => _sfx;

  void setBGM(bool val) {
    AudioManager.instance.sfxPlay('event');
    _settings.put('bgm', val);
    _bgm.value = val;
  }

  void setSFX(bool val) {
    AudioManager.instance.sfxPlay('event');
    _settings.put('sfx', val);
    _sfx.value = val;
  }

  void bgmStart() {
    if (_bgm.value) {
      FlameAudio.bgm.play(filePath['bgm'].toString(), volume: 0.4);
    }
  }

  void bgmStop() {
    if (_bgm.value) {
      FlameAudio.bgm.stop();
    }
  }

  void bgmPause() {
    if (_bgm.value) {
      FlameAudio.bgm.pause();
    }
  }

  void bgmResume() {
    if (_bgm.value) {
      FlameAudio.bgm.resume();
    }
  }

  void sfxPlay(String fx) {
    if (_sfx.value && filePath[fx] != null) {
      FlameAudio.play(filePath[fx].toString());
    }
  }
}
