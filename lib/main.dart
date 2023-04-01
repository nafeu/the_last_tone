import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'games/the_last_tone_game.dart';

void main() {
  final game = TheLastToneGame();
  runApp(GameWidget(game: game));
}
