import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart' show Canvas, Colors, Paint, Rect, TextStyle;
import 'package:the_last_tone/constants/globals.dart';
import 'package:the_last_tone/games/the_last_tone_game.dart';

class ButtonComponent extends Component with TapCallbacks, HasGameRef<TheLastToneGame> {
  late Rect shape;
  final fill = Paint();
  bool _isPressed = false;
  final Function()? onButtonPress;

  final TextPaint textPaint = TextPaint(
    style: TextStyle(
      fontSize: 48.0,
      fontFamily: 'Awesome Font',
      color: Colors.black
    ),
  );

  double x;
  double y;
  double width;
  double height;
  String text;

  ButtonComponent(
    this.x, 
    this.y, 
    this.width, 
    this.height, 
    this.text, 
    this.onButtonPress
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
    onButtonPress!();

    FlameAudio.play(Globals.quackSound);

    _isPressed = true;
  }

  @override
  void render(Canvas canvas) {
    fill.color = _isPressed? Colors.red : Colors.white;
    canvas.drawRect(shape, fill);
    textPaint.render(canvas, text, Vector2(x + width / 2, y + height / 2), anchor: Anchor.center);
  }
}
