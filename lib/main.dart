import 'package:flutter/material.dart';
import 'package:mtg_lifecounter/screens/lifecounter.dart';
import 'package:mtg_lifecounter/screens/config.dart';
import 'package:mtg_lifecounter/models/app_config.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void main() {
  // Register our settings
  getIt.registerSingleton<AppConfig>(new AppConfig());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
      home: Config(),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
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

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> buildLifeCounters() {
    AppConfig config = GetIt.I<AppConfig>();
    List<Widget> result = List(config.playerCount);

    for (int i = 0; i < result.length; i++) {
      result[i] = Expanded(
        child: LifeCounter(
          name: "Player $i",
          startingLife: config.startingLife,
        ),
      );
    }

    return result;
  }
Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            body: SafeArea(
                child: Container(
                    color: Colors.yellow,
                    constraints: BoxConstraints.expand(),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: buildLifeCounters(),
                    ), // Column
                ), // Container
            ), // SafeArea
        ), // Scaffold
    ); // WillPopScope
  }

  void _showBackDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Close Life Counter?"),
              content: Text("Are you sure?"),
              actions: <Widget>[
                new FlatButton(
                    child: Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                ),
                new FlatButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                ),
              ],
          );
        },
    );
  }
}
