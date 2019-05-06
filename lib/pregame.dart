import 'package:flutter/material.dart';
import 'game.dart';
import 'db.dart';
import 'package:uuid/uuid.dart';

class PreGame extends StatefulWidget {
  @override
  _PreGameState createState() => _PreGameState();
}

class _PreGameState extends State<PreGame> {

  getallplayers() async {
    var r = await localDB('getall', null, 'players', null);
    setState(() {
      // players.add(r);
      players.addAll(r);
      print("ist is ${players.length}");
    });
  }

  var players = [];
  var aplayers = [];
  var bplayers = [];
  var apn = [];
  var bpn = [];

  @override
  void initState() {
    getallplayers();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;
    final width = MediaQuery.of(context).size.width / 100;

    return Scaffold(
        body: Container(
      // height: height*75,
      child: (players == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Container(
              height: height * 100,
              child: Column(
                children: <Widget>[
                  Container(
                      width: width * 95,
                      margin: EdgeInsets.only(top: height * 8),
                      child: Text(
                        "Build your team \n  Swipe 👉 Team A | Team B 👈 Swipe",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17),
                      )),
                  Container(
                    height: height * 60,
                    child: ListView.builder(
                      itemCount: players.length,
                      itemBuilder: (BuildContext ctx, int i) {
                        return Container(
                          color: Colors.white,
                          child: Dismissible(
                            background: Container(
                              child: Container(
                                  padding: EdgeInsets.only(
                                      top: height * 4, left: width * 3),
                                  child: Text(
                                    "ADD TO TEAM A",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.blue),
                            ),
                            secondaryBackground: Container(
                                child: Container(
                              padding: EdgeInsets.only(
                                  top: height * 4, right: width * 3),
                              child: Text(
                                "ADD TO TEAM B",
                                textAlign: TextAlign.end,
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.green,
                            )),
                            key: Key(UniqueKey().toString()),
                            child: Container(
                              width: width * 95,
                              margin: EdgeInsets.only(top: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Image(
                                    image:
                                        ExactAssetImage("${players[i]["img"]}"),
                                    width: 30,
                                  ),
                                  Container(
                                    child: Text("${players[i]['name']}"),
                                    margin: EdgeInsets.only(top: 10),
                                  ),
                                ],
                              ),
                            ),
                            onDismissed: (e) {
                              var uuid = new Uuid();
                              if(apn.length >= 4) {

                                String player = players[i];
                                
                                setState(() {
                                  
                                  players.add(player);
                                  // players[i].uniqueid = uuid.v1();
                                });

                                print("More than 4 in A not Allowed");

                              } else if(bpn.length >= 4 ) {

                                print("More than 4 in B not Allowed");

                              } else {

                              if (e == DismissDirection.startToEnd) {
                                aplayers.add(players[i]);
                                apn.add(players[i]["name"]);
                              } else if (e == DismissDirection.endToStart) {
                                bplayers.add(players[i]);
                                bpn.add(players[i]["name"]);

                              }
                              setState(() {
                                players.removeAt(i);
                              });
                              if (aplayers.length >= 4 &&
                                  bplayers.length >= 4) {
                                print("GAME ON");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          GamePage(aplayers, apn, bplayers, bpn),
                                    ));
                              }

                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height * 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 15),
                              height: 50,
                              width: 50,
                              child: Center(
                                child: Text(
                                  "${(4 - apn.length).toString()}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text('TEAM A'),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 15),
                              height: 50,
                              width: 50,
                              child: Center(
                                child: Text(
                                  "${(4 - bpn.length).toString()}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text('TEAM B')
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
    ));
  }
}
