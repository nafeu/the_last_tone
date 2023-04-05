import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:the_last_tone/games/the_last_tone_game.dart';

class GameStatusComponent extends Component with HasGameRef<TheLastToneGame> {
  final paint = Paint();

  late double x;
  late double y;
  late double width;
  late double height;

  final TextPaint textPaint = TextPaint(
    style: TextStyle(
      fontSize: 48.0,
      fontFamily: 'Awesome Font',
      color: Colors.white
    ),
  );

  var rect;
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    x = gameRef.size.x / 2 - 200;
    y = 50;
    width = 400;
    height = 100;

    rect = Rect.fromLTWH(x, y, width, height);
  }

  @override
  void render(Canvas canvas) {
    paint.color = Colors.purple;
    canvas.drawRect(rect, paint);
    textPaint.render(
      canvas, 
      gameRef.gameState, 
      Vector2(x + width / 2, y + height / 2), 
      anchor: Anchor.center
    );
  }
}
