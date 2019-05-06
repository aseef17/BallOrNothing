import 'package:flutter/material.dart';
import 'players.dart';
import 'newplayer.dart';
import 'viewplayer.dart';
import 'pregame.dart';
import 'game.dart';
// import 'db.dart';
import 'pastgames.dart';
import 'playerst.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BallorNothing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => MyHomePage(),
        '/players': (context) => Players(),
        '/newplayer': (context) => NewPlayer(null),
        '/viewplayer': (context) => ViewPlayer(''),
        '/pregame': (context) => PreGame(),
        '/game': (context) => GamePage(null, null, null, null),
        '/pastgames': (context) => PastGames(),
        '/playerst': (context) => PlayerStats(),
      },
      initialRoute: '/',
    );
  }
}

// Navigator.pushNamed(context, '/second');
//   Navigator.pop(context);

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Business logic

  // Database operations

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'WELCOME',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 35, color: Colors.blueAccent),
          ),
          Image.asset(
            'images/logo.png',
            width: 115,
          ),
          RaisedButton(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 95, vertical: 15),
            child: Text('NEW GAME'),
            onPressed: () {
              Navigator.pushNamed(context, '/pregame');
            },
          ),
          RaisedButton(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 95, vertical: 15),
            child: Text('PLAYERS'),
            onPressed: () {
              Navigator.pushNamed(context, '/players');
            },
          ),
          RaisedButton(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 95, vertical: 15),
            child: Text('RECORDS'),
            onPressed: () {
              Navigator.pushNamed(context, '/pastgames');
            },
          ),
        ],
      ),
    ));
  }
}
