import 'package:flutter/material.dart';
import 'db.dart';
import 'viewgame.dart';
import 'main.dart';

class PastGames extends StatefulWidget {
  @override
  _PastGamesState createState() => _PastGamesState();
}

var allgames = [];

class _PastGamesState extends State<PastGames> {

  //Route HomePage = MaterialPageRoute(builder: (context) => MyHomePage());

  @override
  void initState() {
    getgames();
    super.initState();
  }

  Future getgames() async {
    var r = await localDB('getall', null, 'games', null);
    setState(() {
      allgames.addAll(r);
    });
  }

  @override
  void dispose() {
    allgames = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     final height = MediaQuery.of(context).size.height / 100;
    final width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
          child: (allgames.isEmpty)
              ? Container(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Padding(padding: const EdgeInsets.all(25.0)),
                      Text("If no Games have been Played, Press back and Start a New Game", textAlign: TextAlign.center),
                      Padding(padding: const EdgeInsets.only(top: 15.0)),
                      FlatButton(
                        color: Colors.blueAccent,
                        child: new Text("BACK", style: new TextStyle(color: Colors.white)),
                        onPressed: () {
                          // Navigator.of(context).pop();
                          //Navigator.pushReplacementNamed(context, '/');
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                )
              : Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: height*7, bottom: 3),
                        child: Text(
                          'GAME STATS',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 35, color: Colors.blueAccent),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        height: height*65,
                        child: ListView.builder(
                          itemCount: allgames.length,
                          itemBuilder: (BuildContext ctxt, int i) {
                            return InkWell(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 2),
                                color: Colors.white,
                                padding: EdgeInsets.all(15),
                                child: Text("${i+1}.   " + allgames[i]["dt"], textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ViewGame(allgames[i]),
                                    ));
                              },
                            );
                          },
                        ),
                      ),
                       Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: RaisedButton(
                        color: Colors.blue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 95, vertical: 15),
                        child: Text(
                          'PLAYER RECORDS',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                       Navigator.pushNamed(context, '/playerstats');
                        },
                      ),
                    ),
                  ),
                )
                    ],
                  ),
                )),
    );
  }
}
