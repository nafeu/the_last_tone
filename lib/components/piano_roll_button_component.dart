import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart' show Canvas, Colors, Paint, Rect, TextStyle;
import 'package:the_last_tone/constants/globals.dart';
import 'package:the_last_tone/constants/states.dart';
import 'package:the_last_tone/games/the_last_tone_game.dart';

class PianoRollButtonComponent extends Component with TapCallbacks, HasGameRef<TheLastToneGame> {
  late Rect shape;
  final fill = Paint();
  bool _isPressed = false;
  bool isActive = false;

  final TextPaint whiteTextPaint = TextPaint(
    style: TextStyle(
      fontSize: 24.0,
      fontFamily: 'Awesome Font',
      color: Colors.white
    ),
  );

  final TextPaint blackTextPaint = TextPaint(
    style: TextStyle(
      fontSize: 24.0,
      fontFamily: 'Awesome Font',
      color: Colors.black
    ),
  );

  double x;
  double y;
  double width;
  double height;

  String option;

  set setOption(String value) {
    option = value;
  }

  set setIsActive(bool value) {
    isActive = value;
  }

  PianoRollButtonComponent(
    this.x,
    this.y,
    this.width,
    this.height,
    this.option,
    this.isActive
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    shape = Rect.fromLTWH(x, y, width, height);
  }

  @override
  bool containsLocalPoint(Vector2 point) => shape.contains(point.toOffset());

  @override
  void onTapUp(TapUpEvent event) => _isPressed = false;

  @override
  void onTapCancel(TapCancelEvent event) => _isPressed = false;

  @override
  void onTapDown(TapDownEvent event) {
    if (
      gameRef.playerState == PlayerState.WAITING
        && (gameRef.gameState != GameState.YOU_WIN && gameRef.gameState != GameState.GAME_OVER)
    ) {
      if (isActive && gameRef.playerEnergy > 0) {
        FlameAudio.play(Globals.pianoNoteMapping[option]!);
        gameRef.playerEnergy -= 1;
      }

      _isPressed = true;
    }
  }

  @override
  void render(Canvas canvas) {
    bool isBlackKey = option.contains('#');

    if (isActive) {
      if (gameRef.playerEnergy == 0) {
        fill.color = Colors.grey;
      } else {
        fill.color = _isPressed? Colors.yellow : (isBlackKey ? Colors.black : Colors.white);
      }

      canvas.drawRect(shape, fill);

      if (isBlackKey) {
        whiteTextPaint.render(
          canvas,
          option,
          Vector2(x + width / 2, y + height / 2),
          anchor: Anchor.center
        );
      } else {
        blackTextPaint.render(
          canvas,
          option,
          Vector2(x + width / 2, y + height / 2),
          anchor: Anchor.center
        );
      }
    } else {
      fill.color = Colors.blue.shade600;
      canvas.drawRect(shape, fill);
    }
  }
}
