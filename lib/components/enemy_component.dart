import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:the_last_tone/games/the_last_tone_game.dart';

class EnemyComponent extends Component with HasGameRef<TheLastToneGame> {
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

  void updateEnemyState() {
    if (gameRef.enemyState == 'HURT') {
      gameRef.setEnemyStateIn(1, 'WAITING', 'RECOVERING');
    }    
    else if (gameRef.enemyState == 'WAITING') {
      gameRef.setEnemyStateIn(1, 'PLAYED_MOVE', 'MAKING_MOVE', (){
        gameRef.enemyMove = (['A', 'B', 'C', 'D'].toList()..shuffle()).first;
        gameRef.playerState = 'WAITING';
      });
    }
    else if (gameRef.enemyState == 'PLAYED_MOVE') {
      gameRef.setEnemyStateIn(1, 'IDLE', 'RESETTING');
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
  }

  @override
  void render(Canvas canvas) {
    paint.color = Colors.red;
    canvas.drawRect(rect, paint);
    textPaint.render(
      canvas, 
      'HP: ${gameRef.enemyHealth}\nSTATE: ${gameRef.enemyState}\nMOVE: ${gameRef.enemyMove}', 
      Vector2(x + width / 2, y + height / 2), 
      anchor: Anchor.center
    );        
  }  

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.gameState != 'GAME OVER' && gameRef.gameState != 'YOU WIN') {
      updateEnemyState();
    }    
  }  
}
