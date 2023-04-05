import 'package:flame/components.dart';
import 'package:the_last_tone/components/button_component.dart';
import 'package:the_last_tone/games/the_last_tone_game.dart';

class ButtonManagerComponent extends Component with HasGameRef<TheLastToneGame> {
  ButtonManagerComponent();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    Vector2 size = gameRef.size;

    double buttonWidth = size.x * 0.25;
    double buttonHeight = size.y * 0.5 - buttonWidth;
    double yOffset = 100;

    addAll([
      ButtonComponent(
        buttonWidth, 
        yOffset + buttonHeight, 
        buttonWidth, 
        size.y * 0.125,
        'A',
        () { gameRef.handleButtonClick('A'); }
      ),
      ButtonComponent(
        buttonWidth + buttonWidth, 
        yOffset + buttonHeight, 
        buttonWidth, 
        size.y * 0.125,
        'B',
        () { gameRef.handleButtonClick('B'); }
      ),
      ButtonComponent(
        buttonWidth, 
        yOffset + buttonHeight + (size.y * 0.125), 
        buttonWidth, 
        size.y * 0.125,
        'C',
        () { gameRef.handleButtonClick('C'); }
      ),
      ButtonComponent(
        buttonWidth + buttonWidth, 
        yOffset + buttonHeight + (size.y * 0.125), 
        buttonWidth, 
        size.y * 0.125,
        'D',
        () { gameRef.handleButtonClick('D'); }
      ),
    ]);
  }
}
