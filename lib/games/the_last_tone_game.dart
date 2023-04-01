import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:the_last_tone/components/background_component.dart';
import 'package:the_last_tone/components/button_manager_component.dart';
import 'package:the_last_tone/constants/globals.dart';

class TheLastToneGame extends FlameGame with HasTappableComponents {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await FlameAudio.audioCache.load(Globals.quackSound);

    add(BackgroundComponent());
    add(ButtonManagerComponent());
  }
}
