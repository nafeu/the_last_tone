import 'package:flame/components.dart';
import 'package:the_last_tone/components/piano_roll_button_component.dart';
import 'package:the_last_tone/constants/globals.dart';
import 'package:the_last_tone/constants/states.dart';
import 'package:the_last_tone/games/the_last_tone_game.dart';
import 'package:the_last_tone/utils/helpers.dart';

class PianoRollButtonManagerComponent extends Component with HasGameRef<TheLastToneGame> {
  PianoRollButtonManagerComponent();

  late List<Component> buttons;
  List<bool> activatedButtons = List.generate(Globals.musicalNotes.length, (_) => false);

  double buttonWidth = 35;
  double buttonHeight = 100;
  double xMargin = 5;
  double blackKeyYOffset = 20;
  late double xOffset;
  late double yOffset;

  void activateRandomButton() {
    setNUniqueTrue(activatedButtons, 3);

    for (var i = 0; i < buttons.length; i++) {
      PianoRollButtonComponent button = buttons[i] as PianoRollButtonComponent;

      button.setIsActive = activatedButtons[i];
    }
  }

  void updatePianoRollButtonManagerState() {
    if (gameRef.pianoRollButtonManagerState == PianoRollButtonManagerState.ACTIVATE_RANDOM_BUTTON) {
      activateRandomButton();
      gameRef.setPianoRollButtonManagerStateIn(1, PianoRollButtonManagerState.ACTIVATING, PianoRollButtonManagerState.IDLE);
    }
  }

  List<Component> buildPianoRollButtonComponents() {
    List<Component> output = [];

    for (var index = 0; index < Globals.musicalNotes.length; index++) {
      String option = Globals.musicalNotes[index];

      final xPos = index;
      bool isBlackKey = option.contains('#');

      output.add(
        PianoRollButtonComponent(
          xOffset + (xPos * buttonWidth) + (xMargin * xPos),
          yOffset + buttonHeight - (isBlackKey ? blackKeyYOffset : 0),
          buttonWidth,
          buttonHeight,
          option,
          activatedButtons[index]
        )
      );
    }

    return output;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    Vector2 size = gameRef.size;

    xOffset = (size.x / 2) - ((buttonWidth + xMargin) * Globals.musicalNotes.length) / 2 + (xMargin / 2);
    yOffset = (size.y / 2) - buttonHeight + 200;

    buttons = buildPianoRollButtonComponents();
    addAll(buttons);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.gameState != GameState.GAME_OVER && gameRef.gameState != GameState.YOU_WIN) {
      updatePianoRollButtonManagerState();
    }
  }
}
