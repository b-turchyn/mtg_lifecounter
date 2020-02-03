class AppConfig {
  static const List<int> PLAYER_COUNT_OPTS = [2, 3, 4];
  static const List<int> STARTING_LIFE_OPTS = [20, 30, 40];

  int _playerCount = 4;
  int _startingLife = 30;

  get playerCount => _playerCount;
  get startingLife => _startingLife;

  set playerCount(int count) {
    _playerCount = count;
  }

  set startingLife(int life) {
    _startingLife = life;
  }
}
