import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'dart:developer' as developer;
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class LifeCounter extends StatefulWidget {
  LifeCounter({Key key, this.name, this.startingLife}) : super(key: key);

  final String name;
  final int startingLife;

  @override
  _LifeCounterState createState() => _LifeCounterState();
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
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
      developer.log('Done');
    });
  }

  @override
  Widget build(BuildContext context) {
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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.yellow,
          constraints: BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child: LifeCounter(name: 'Brian', startingLife: 20),),
              Expanded(child: LifeCounter(name: 'Josh', startingLife: 20),),
              Expanded(child: LifeCounter(name: 'Erin', startingLife: 30),),
            ],
          ), // Column
        ), // Container
      ), // SafeArea
    ); // Scaffold
  }
}
