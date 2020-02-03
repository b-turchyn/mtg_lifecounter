import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'dart:developer' as developer;
import 'dart:async';

class LifeCounter extends StatefulWidget {
  LifeCounter({Key key, this.name, this.startingLife}) : super(key: key);

  final String name;
  final int startingLife;

  @override
  _LifeCounterState createState() => _LifeCounterState();
}

class _LifeCounterState extends State<LifeCounter> {
  static const DURATION = Duration(seconds: 2);

  String _name = "";
  int _life = null;
  int _lifeDiff = 0;
  Timer _displayTimeout = null;
  double _diffOpacity = 0.0;

  void startTimer() {
    if (_displayTimeout != null) {
      _displayTimeout.cancel();
    }
    _diffOpacity = 1.0;
    _displayTimeout = new Timer(DURATION, () {
      setState(() {
        _diffOpacity = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    _name = widget.name;
    _life = (_life == null ? widget.startingLife : _life);
    return GestureDetector(
      onTapUp: (details) {
        setState(() {
          double midway = context.size.width / 2.0;
          if (midway <= details.localPosition.dx) {
            _life++;
            _lifeDiff++;
          } else {
            _life--;
            _lifeDiff--;
          }
          startTimer();
        });
      },
      child: Container(
        color: Colors.black,
        margin: EdgeInsets.all(4.0),
        constraints: BoxConstraints.expand(),
        child: Center (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$_life',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 64.0,
                ),
              ),
              Text(
                '$_name',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 250),
                opacity: _diffOpacity,
                onEnd: () {
                  if (_diffOpacity == 0.0) {
                    _lifeDiff = 0;
                  }
                },
                child: Text(
                  '$_lifeDiff',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ), // Center
      ),
    );
  }
}

