import 'dart:async';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:the_last_tone/components/background_component.dart';
import 'package:the_last_tone/components/button_manager_component.dart';
import 'package:the_last_tone/components/enemy_component.dart';
import 'package:the_last_tone/components/game_status_component.dart';
import 'package:the_last_tone/components/piano_roll_button_manager_component.dart';
import 'package:the_last_tone/components/player_component.dart';
import 'package:the_last_tone/constants/globals.dart';
import 'package:the_last_tone/constants/states.dart';

class TheLastToneGame extends FlameGame with HasTappableComponents {
  GameState gameState = GameState.ACTIVE;
  Timer gameStateTimer = Timer(Duration(seconds: 0), (){});

  PlayerState playerState = PlayerState.IDLE;
  Timer playerStateTimer = Timer(Duration(seconds: 0), (){});
  String playerMove = '';
  int playerHealth = 3;
  int playerEnergy = 3;

  EnemyState enemyState = EnemyState.WAITING;
  Timer enemyStateTimer = Timer(Duration(seconds: 0), (){});
  String enemyMove = '';
  int enemyHealth = 3;

  ButtonManagerState buttonManagerState = ButtonManagerState.EMPTY;
  Timer buttonManagerStateTimer = Timer(Duration(seconds: 0), (){});

  PianoRollButtonManagerState pianoRollButtonManagerState = PianoRollButtonManagerState.ACTIVATE_RANDOM_BUTTON;
  Timer pianoRollButtonManagerStateTimer = Timer(Duration(seconds: 0), (){});

  List<String> options = ['?', '?', '?', '?'];

  void handleButtonClick(String text) {
    playerMove = text;
    playerState = PlayerState.PLAYED_MOVE;
    buttonManagerState = ButtonManagerState.GENERATE_ANSWERS;
  }

  void updateGameState() {
    if (gameState == GameState.ACTIVE) {
      if (playerState == PlayerState.DEAD) {
        gameState = GameState.GAME_OVER;
      } else if (enemyState == EnemyState.DEAD) {
        gameState = GameState.YOU_WIN;
      }
    }
  }

  void setGameStateIn(
    int seconds,
    GameState newState,
    GameState transitionState
  ) {
    gameStateTimer.cancel();
    gameStateTimer = Timer(
      Duration(seconds: seconds),
      () {
        gameState = newState;
      }
    );
  }

  void setPlayerStateIn(
    int seconds,
    PlayerState newState,
    PlayerState transitionState,
    [Function? callback]
  ) {
    playerState = transitionState;
    playerStateTimer.cancel();
    playerStateTimer = Timer(
      Duration(seconds: seconds),
      () {
        playerState = newState;
        if (callback != null) {
          callback();
        }
      }
    );
  }

  void setEnemyStateIn(
    int seconds,
    EnemyState newState,
    EnemyState transitionState,
    [Function? callback]
  ) {
    enemyState = transitionState;
    enemyStateTimer.cancel();
    enemyStateTimer = Timer(
      Duration(seconds: seconds),
      () {
        enemyState = newState;
        if (callback != null) {
          callback();
        }
      }
    );
  }

  void setButtonManagerStateIn(
    int seconds,
    ButtonManagerState newState,
    ButtonManagerState transitionState,
    [Function? callback]
  ) {
    buttonManagerState = transitionState;
    buttonManagerStateTimer.cancel();
    buttonManagerStateTimer = Timer(
      Duration(seconds: seconds),
      () {
        buttonManagerState = newState;
        if (callback != null) {
          callback();
        }
      }
    );
  }

  void setPianoRollButtonManagerStateIn(
    int seconds,
    PianoRollButtonManagerState newState,
    PianoRollButtonManagerState transitionState,
    [Function? callback]
  ) {
    pianoRollButtonManagerState = transitionState;
    pianoRollButtonManagerStateTimer.cancel();
    pianoRollButtonManagerStateTimer = Timer(
      Duration(seconds: seconds),
      () {
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
