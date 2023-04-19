import 'package:flame/components.dart';
import 'package:the_last_tone/components/button_component.dart';
import 'package:the_last_tone/constants/states.dart';
import 'package:the_last_tone/games/the_last_tone_game.dart';

class ButtonManagerComponent extends Component with HasGameRef<TheLastToneGame> {
  ButtonManagerComponent();

  late List<Component> buttons;

  double buttonWidth = 200;
  double buttonHeight = 100;
  late double xOffset;
  late double yOffset;

  void updateButtonOptions() {
    for (var i = 0; i < buttons.length; i++) {
      ButtonComponent button = buttons[i] as ButtonComponent;

      button.setOption = gameRef.options[i];
    }
  }

  void updateButtonManagerState() {
    if (gameRef.buttonManagerState == ButtonManagerState.GENERATE_ANSWERS) {
      updateButtonOptions();
      gameRef.setButtonManagerStateIn(1, ButtonManagerState.WAITING, ButtonManagerState.SHUFFLING);
    }
  }

  List<Component> buildButtonComponents() {
    List<Component> output = [];

    for (var index = 0; index < gameRef.options.length; index++) {
      String option = gameRef.options[index];

      final xPos = index % 2;
      final yPos = (index / 2).floor();

      output.add(
        ButtonComponent(
          xOffset + (xPos * buttonWidth),
          yOffset + (yPos * buttonHeight),
          buttonWidth,
          buttonHeight,
          option
        )
      );
    }

    return output;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    Vector2 size = gameRef.size;

    xOffset = (size.x / 2) - buttonWidth;
    yOffset = (size.y / 2) - buttonHeight;

    buttons = buildButtonComponents();
    addAll(buttons);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.gameState != GameState.GAME_OVER && gameRef.gameState != GameState.YOU_WIN) {
      updateButtonManagerState();
    }
  }
}
