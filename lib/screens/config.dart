import 'package:flutter/material.dart';
import 'package:mtg_lifecounter/models/app_config.dart';
import 'package:mtg_lifecounter/main.dart';
import 'package:get_it/get_it.dart';

class Config extends StatefulWidget {
  Config({Key key}) : super(key: key);

  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  List<bool> _selectedPlayers = null;
  List<bool> _selectedStartingLife = null;

  void initPlayerCount() {
    if (_selectedPlayers == null) {
      AppConfig config = GetIt.I<AppConfig>();
      List<int> options = AppConfig.PLAYER_COUNT_OPTS;
      _selectedPlayers = List.filled(options.length, false);
      for (int i = 0; i < options.length; i++) {
        if (config.playerCount == options[i]) {
          _selectedPlayers[0] = true;
        }
      }
    }
  }

  void initStartingLife() {
    if (_selectedStartingLife == null) {
      AppConfig config = GetIt.I<AppConfig>();
      List<int> options = AppConfig.STARTING_LIFE_OPTS;
      _selectedStartingLife = List.filled(options.length, false);
      for (int i = 0; i < options.length; i++) {
        if (config.playerCount == options[i]) {
          _selectedStartingLife[0] = true;
        }
      }
    }
  }

  List<Widget> buildTextList(List<dynamic> options) {
    List<Widget> result = List<Widget>(options.length);

    for (int i = 0; i < options.length; i++) {
      result[i] = Text(options[i].toString());
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    AppConfig config = GetIt.I<AppConfig>();
    initPlayerCount();
    initStartingLife();

    return Scaffold(
      appBar: AppBar(
        title: Text('Life Tracker'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Text("Player Count"),
              ToggleButtons(
                children: buildTextList(AppConfig.PLAYER_COUNT_OPTS),
                isSelected: _selectedPlayers,
                onPressed: (int index) {
                  config.playerCountIndex = index;
                  setState(() {
                    for (int buttonIndex = 0;
                        buttonIndex < _selectedPlayers.length;
                        buttonIndex++) {
                      if (buttonIndex == index) {
                        _selectedPlayers[buttonIndex] = true;
                      } else {
                        _selectedPlayers[buttonIndex] = false;
                      }
                    }
                  });
                },
              ),
              Text("Starting Life"),
              ToggleButtons(
                children: buildTextList(AppConfig.STARTING_LIFE_OPTS),
                isSelected: _selectedStartingLife,
                onPressed: (int index) {
                  setState(() {
                    config.startingLifeIndex = index;
                    for (int buttonIndex = 0;
                        buttonIndex < _selectedStartingLife.length;
                        buttonIndex++) {
                      if (buttonIndex == index) {
                        _selectedStartingLife[buttonIndex] = true;
                      } else {
                        _selectedStartingLife[buttonIndex] = false;
                      }
                    }
                  });
                },
              ),
              OutlineButton(
                child: Text('Start'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
