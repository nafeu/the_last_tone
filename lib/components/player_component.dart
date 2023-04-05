import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:the_last_tone/games/the_last_tone_game.dart';

class PlayerComponent extends Component with HasGameRef<TheLastToneGame> {
  final paint = Paint();
  var rect;

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

  void updatePlayerState() {
    if (gameRef.playerState == 'HURT') {
      gameRef.setPlayerStateIn(1, 'IDLE', 'RECOVERING');
    }
    else if (gameRef.playerState == 'PLAYED_MOVE') {
      if (gameRef.playerMove == gameRef.enemyMove) {
        gameRef.playerState = 'WAITING';
        gameRef.enemyHealth -= 1;
        if (gameRef.enemyHealth <= 0) {
          gameRef.setEnemyStateIn(1, 'DEAD', 'DYING');
        } else {
          gameRef.setEnemyStateIn(1, 'HURT', 'HURTING');
        }
      } else {
        gameRef.playerHealth -= 1;
        if (gameRef.playerHealth <= 0) {
          gameRef.setPlayerStateIn(1, 'DEAD', 'DYING');
        } else {
          gameRef.setPlayerStateIn(1, 'HURT', 'HURTING');
          gameRef.enemyState = 'WAITING';
        }        
      }

      gameRef.playerMove = 'P';
      gameRef.enemyMove = 'E';
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    x = gameRef.size.x / 4 - 50;
    y = 185;
    width = 100;
    height = 100;

    rect = Rect.fromLTWH(x, y, width, height);
  }

  @override
  void render(Canvas canvas) {
    paint.color = Colors.green;
    canvas.drawRect(rect, paint);
    textPaint.render(
      canvas, 
      'HP: ${gameRef.playerHealth}\nSTATE: ${gameRef.playerState}\nMOVE: ${gameRef.playerMove}', 
      Vector2(x + width / 2, y + height / 2), 
      anchor: Anchor.center
    );    
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.gameState != 'GAME OVER' && gameRef.gameState != 'YOU WIN') {
      updatePlayerState();
    }
  }
}
