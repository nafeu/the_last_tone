import 'package:flame/components.dart';
import 'package:the_last_tone/components/button_component.dart';
import 'package:the_last_tone/games/the_last_tone_game.dart';

class ButtonManagerComponent extends Component with HasGameRef<TheLastToneGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    Vector2 size = gameRef.size;

    double buttonWidth = size.x * 0.25;
    double buttonHeight = size.y * 0.5 - buttonWidth;

    addAll([
      ButtonComponent(
        buttonWidth, 
        buttonHeight, 
        buttonWidth, 
        size.y * 0.125,
        'A',
        () { print('USER PRESSED A'); }
      ),
      ButtonComponent(
        buttonWidth + buttonWidth, 
        buttonHeight, 
        buttonWidth, 
        size.y * 0.125,
        'B',
        () { print('USER PRESSED B'); }
      ),
      ButtonComponent(
        buttonWidth, 
        buttonHeight + (size.y * 0.125), 
        buttonWidth, 
        size.y * 0.125,
        'C',
        () { print('USER PRESSED C'); }
      ),
      ButtonComponent(
        buttonWidth + buttonWidth, 
        buttonHeight + (size.y * 0.125), 
        buttonWidth, 
        size.y * 0.125,
        'D',
        () { print('USER PRESSED D'); }
      ),
    ]);
  }
}
