import 'package:flutter/material.dart';
import 'db.dart';
import 'viewgame.dart';

class PastGames extends StatefulWidget {
  @override
  _PastGamesState createState() => _PastGamesState();
}

class _PastGamesState extends State<PastGames> {
  Future getgames() async {
    var r = await localDB('getall', null, 'games', null);
    return r;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;
    final width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: FutureBuilder(
            future: getgames(),
            builder: (context, snap) {
              if (snap.hasData &&
                  snap.connectionState == ConnectionState.done &&
                  snap.data.isNotEmpty) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: height * 7, bottom: 3),
                        child: Text(
                          'GAME STATS',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 35, color: Colors.blueAccent),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        height: height * 65,
                        child: ListView.builder(
                          itemCount: snap.data.length,
                          itemBuilder: (BuildContext ctxt, int i) {
                            return InkWell(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 2),
                                color: Colors.white,
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  "${i + 1}.   " + snap.data[i]["dt"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ViewGame(snap.data[i]),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 95, vertical: 15),
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
                );
              } else if (snap.connectionState == ConnectionState.done) {
                return Container(
                  width: width * 100,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Play some games first to see stats data",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22, height: 1.5),
                        ),
                      ),
                      FlatButton(
                        color: Colors.blueAccent,
                        child: new Text("BACK",
                            style: new TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                );
              } else if (snap.connectionState == ConnectionState.active ||
                  snap.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Container();
              }
            }));
  }
}
