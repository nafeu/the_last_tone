import 'dart:async';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:the_last_tone/components/background_component.dart';
import 'package:the_last_tone/components/button_manager_component.dart';
import 'package:the_last_tone/components/enemy_component.dart';
import 'package:the_last_tone/components/game_status_component.dart';
import 'package:the_last_tone/components/player_component.dart';
import 'package:the_last_tone/constants/globals.dart';
import 'package:the_last_tone/utils/helpers.dart';

import '../components/piano_roll_button_manager_component.dart';

class TheLastToneGame extends FlameGame with HasTappableComponents {
  String gameState = 'ACTIVE';
  Timer gameStateTimer = Timer(Duration(seconds: 0), (){});

  String playerState = 'IDLE';
  Timer playerStateTimer = Timer(Duration(seconds: 0), (){});
  String playerMove = '';
  int playerHealth = 3;

  String enemyState = 'WAITING';
  Timer enemyStateTimer = Timer(Duration(seconds: 0), (){});
  String enemyMove = '';
  int enemyHealth = 3;

  String buttonManagerState = 'EMPTY';
  Timer buttonManagerStateTimer = Timer(Duration(seconds: 0), (){});

  String pianoRollButtonManagerState = 'EMPTY';
  Timer pianoRollButtonManagerStateTimer = Timer(Duration(seconds: 0), (){});

  List<String> options = ['?', '?', '?', '?'];

  void handleButtonClick(String text) {
    playerMove = text;
    playerState = 'PLAYED_MOVE';
    buttonManagerState = 'GENERATE_ANSWERS';
  }

  void updateGameState() {
    if (gameState == 'ACTIVE') {
      if (playerState == 'DEAD') {
        gameState = 'GAME OVER';
      } else if (enemyState == 'DEAD') {
        gameState = 'YOU WIN';
      }
    }
  }

  void setGameStateIn(int seconds, String newState, String transitionState) {
    gameStateTimer.cancel();
    gameStateTimer = Timer(
      Duration(seconds: seconds),
      () {
        print('GAME STATE FROM [$gameState] -> [$newState]');
        gameState = newState;
      }
    );
  }

  void setPlayerStateIn(
    int seconds,
    String newState,
    String transitionState,
    [Function? callback]
  ) {
    playerState = transitionState;
    playerStateTimer.cancel();
    playerStateTimer = Timer(
      Duration(seconds: seconds),
      () {
        print('PLAYER STATE FROM [$playerState] -> [$newState]');
        playerState = newState;
        if (callback != null) {
          callback();
        }
      }
    );
  }

  void setEnemyStateIn(
    int seconds,
    String newState,
    String transitionState,
    [Function? callback]
  ) {
    enemyState = transitionState;
    enemyStateTimer.cancel();
    enemyStateTimer = Timer(
      Duration(seconds: seconds),
      () {
        print('ENEMY STATE FROM [$enemyState] -> [$newState]');
        enemyState = newState;
        if (callback != null) {
          callback();
        }
      }
    );
  }

  void setButtonManagerStateIn(
    int seconds,
    String newState,
    String transitionState,
    [Function? callback]
  ) {
    buttonManagerState = transitionState;
    buttonManagerStateTimer.cancel();
    buttonManagerStateTimer = Timer(
      Duration(seconds: seconds),
      () {
        print('BUTTON MANAGER STATE FROM [$buttonManagerState] -> [$newState]');
        buttonManagerState = newState;
        if (callback != null) {
          callback();
        }
      }
    );
  }

  void setPianoRollButtonManagerStateIn(
    int seconds,
    String newState,
    String transitionState,
    [Function? callback]
  ) {
    pianoRollButtonManagerState = transitionState;
    pianoRollButtonManagerStateTimer.cancel();
    pianoRollButtonManagerStateTimer = Timer(
      Duration(seconds: seconds),
      () {
        print('BUTTON MANAGER STATE FROM [$pianoRollButtonManagerState] -> [$newState]');
        pianoRollButtonManagerState = newState;
        if (callback != null) {
          callback();
        }
      }
    );
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await FlameAudio.audioCache.load(Globals.quackSound);
    await FlameAudio.audioCache.load(Globals.oofSound);
    await FlameAudio.audioCache.loadAll(Globals.pianoSounds);

    add(BackgroundComponent());
    add(GameStatusComponent());
    add(PlayerComponent());
    add(EnemyComponent());
    add(ButtonManagerComponent());
    add(PianoRollButtonManagerComponent());
  }

  @override
  void update(double dt) {
    super.update(dt);
    updateGameState();
  }
}
