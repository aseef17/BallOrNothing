import 'package:flutter/material.dart';
import 'db.dart';
import 'viewgame.dart';
import 'playerst.dart';

class PastGames extends StatefulWidget {
  @override
  _PastGamesState createState() => _PastGamesState();
}

var allgames = [];

class _PastGamesState extends State<PastGames> {
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
    return Scaffold(
      body: Container(
          child: (allgames.isEmpty)
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 60, bottom: 30),
                        child: Text(
                          'GAME STATS',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 35, color: Colors.blueAccent),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        height: 550,
                        child: ListView.builder(
                          itemCount: allgames.length,
                          itemBuilder: (BuildContext ctxt, int i) {
                            return InkWell(
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Text(allgames[i]["dt"], style: TextStyle(fontSize: 18),),
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
