import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:the_last_tone/games/the_last_tone_game.dart';

class BackgroundComponent extends Component with HasGameRef<TheLastToneGame> {
  final paint = Paint();
  var rect;
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    rect = Rect.fromLTWH(0, 0, gameRef.size.x, gameRef.size.y);
  }

  @override
  void render(Canvas canvas) {
    paint.color = Colors.blue;
    canvas.drawRect(rect, paint);
  }  
}
