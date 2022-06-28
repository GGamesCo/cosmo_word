import 'package:flame_audio/flame_audio.dart';
import 'package:injectable/injectable.dart';

@singleton
class SoundsController{
  static const String BTN_PRESS_1 = 'btn-press-1.mp3';
  static const String BTN_PRESS_2 = 'btn-press-2.mp3';
  static const String BTN_PRESS_3 = 'btn-press-3.mp3';
  static const String BTN_PRESS_4 = 'btn-press-4.mp3';
  static const String BTN_PRESS_5 = 'btn-press-5.mp3';
  static const String FAIL = 'fail.mp3';
  static const String FALL = 'fall.mp3';
  static const String INPUT_SUCCESS = 'success.mp3';
  static const String SHUFFLE_JOYSTICK = 'shuffle-joystick.mp3';
  static const String CLOCK = 'clock.mp3';
  static const String WIN_APPLAUSE = 'win-applause.mp3';
  static const String WIN_SIMPLE = 'win-simple.mp3';
  static const String LOBBY = 'lobby.mp3';

  Future initAsync() async{
    await FlameAudio.audioCache.loadAll([
      BTN_PRESS_1,
      BTN_PRESS_2,
      BTN_PRESS_3,
      BTN_PRESS_4,
      BTN_PRESS_5,
      FAIL,
      FALL,
      INPUT_SUCCESS,
      SHUFFLE_JOYSTICK,
      CLOCK,
      WIN_APPLAUSE,
      WIN_SIMPLE,
    ]);
  }
}