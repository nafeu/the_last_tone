enum PlayerState {
  DEAD,
  DYING,
  HURT,
  HURTING,
  IDLE,
  PLAYED_MOVE,
  RECOVERING,
  WAITING,
}

enum GameState {
  ACTIVE,
  GAME_OVER,
  YOU_WIN,
}

enum EnemyState {
  DEAD,
  DYING,
  HURT,
  HURTING,
  IDLE,
  MAKING_MOVE,
  PLAYED_MOVE,
  RECOVERING,
  RESETTING,
  WAITING,
}

enum ButtonManagerState {
  EMPTY,
  GENERATE_ANSWERS,
  SHUFFLING,
  WAITING,
}

enum PianoRollButtonManagerState {
  ACTIVATE_RANDOM_BUTTON,
  ACTIVATING,
  IDLE,
}