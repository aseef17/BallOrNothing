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
    // TODO: implement dispose
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 60),
                        child: Text(
                          "GAME STATS",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        height: 300,
                        child: ListView.builder(
                          itemCount: allgames.length,
                          itemBuilder: (BuildContext ctxt, int i) {
                            return InkWell(
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Text(allgames[i]["dt"]),
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
                      Container(
                        child: RaisedButton(
                          color: Colors.amber,
                          padding: EdgeInsets.all(2),
                          child: Text(
                            "Player stats",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/playerst');
                          },
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }
}
