import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:the_last_tone/constants/globals.dart';
import 'package:the_last_tone/constants/states.dart';
import 'package:the_last_tone/games/the_last_tone_game.dart';
import 'package:the_last_tone/utils/helpers.dart';

class EnemyComponent extends Component with TapCallbacks, HasGameRef<TheLastToneGame> {
  late Rect shape;
  final paint = Paint();
  var rect;
  bool _isPressed = false;

  late double x;
  late double y;
  late double width;
  late double height;

  final TextPaint textPaint = TextPaint(
    style: TextStyle(
      fontSize: 20.0,
      fontFamily: 'Awesome Font',
      color: Colors.white
    ),
  );

  void updateEnemyState() {
    if (gameRef.enemyState == EnemyState.HURT) {
      gameRef.setEnemyStateIn(1, EnemyState.WAITING, EnemyState.RECOVERING);
    }
    else if (gameRef.enemyState == EnemyState.WAITING) {
      gameRef.options = getNRandomNotes(4);
      gameRef.buttonManagerState = ButtonManagerState.GENERATE_ANSWERS;
      gameRef.setEnemyStateIn(1, EnemyState.PLAYED_MOVE, EnemyState.MAKING_MOVE, (){
        gameRef.enemyMove = (gameRef.options.toList()..shuffle()).first;
        FlameAudio.play(Globals.pianoNoteMapping[gameRef.enemyMove]!);
        gameRef.playerState = PlayerState.WAITING;
      });
    }
    else if (gameRef.enemyState == EnemyState.PLAYED_MOVE) {
      gameRef.setEnemyStateIn(1, EnemyState.IDLE, EnemyState.RESETTING);
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    x = gameRef.size.x - (gameRef.size.x / 4 + 50);
    y = 185;
    width = 100;
    height = 100;

    rect = Rect.fromLTWH(gameRef.size.x - (gameRef.size.x / 4 + 50), 185, 100, 100);
    shape = Rect.fromLTWH(gameRef.size.x - (gameRef.size.x / 4 + 50), 185, 100, 100);
  }

  @override
  void render(Canvas canvas) {
    paint.color = Colors.red;
    canvas.drawRect(rect, paint);
    textPaint.render(
      canvas,
      '${gameRef.enemyState}\nHP: ${gameRef.enemyHealth}',
      Vector2(x + width / 2, y + height / 2),
      anchor: Anchor.center
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.gameState != GameState.GAME_OVER && gameRef.gameState != GameState.YOU_WIN) {
      updateEnemyState();
    }
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
      gameRef.enemyState == EnemyState.IDLE
        && (gameRef.gameState != GameState.YOU_WIN && gameRef.gameState != GameState.GAME_OVER)
    ) {
      if (gameRef.playerEnergy > 0) {
        FlameAudio.play(Globals.pianoNoteMapping[gameRef.enemyMove]!);
        gameRef.playerEnergy -= 1;
      }

      _isPressed = true;
    }
  }
}
