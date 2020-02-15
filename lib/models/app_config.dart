import 'dart:developer' as developer;

class AppConfig {
  static const List<int> PLAYER_COUNT_OPTS = [2, 3, 4];
  static const List<int> STARTING_LIFE_OPTS = [20, 30, 40];

  int _playerCount = 2;
  int _startingLife = 20;

  get playerCount => _playerCount;
  get startingLife => _startingLife;

  set playerCount(int count) {
    _playerCount = count;
    developer.log("Player count set to $count");
  }

  set playerCountIndex(int index) {
    _playerCount = PLAYER_COUNT_OPTS[index];
    developer.log("Player count set to $_playerCount");
  }

  set startingLife(int life) {
    _startingLife = life;
    developer.log("Starting life set to $life");
  }

  set startingLifeIndex(int index) {
    _startingLife = STARTING_LIFE_OPTS[index];
    developer.log("Starting life set to $_startingLife");
  }
}
