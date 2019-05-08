import 'dart:collection';

import 'package:flutter/material.dart';
import 'db.dart';
import 'main.dart';

class GamePage extends StatefulWidget {
  var ateam, ateamn;
  var bteam, bteamn;
  GamePage(this.ateam, this.ateamn, this.bteam, this.bteamn, {Key key})
      : super(key: key);
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  var ass, bss, wss, ascoress, bscoress;
  var freeze = false;

  var players = [];

  getplayers() async {
    var r = await localDB('getall', null, 'players', null);
    setState(() {
      players.addAll(r);
    });
  }

  @override
  void initState() {
    super.initState();
    getplayers();
  }

  Route HomePage = MaterialPageRoute(builder: (context) => MyHomePage());

  var cols = ["PTS", "2PM", "2PA", "3PM", "3PA", "REB", "AST", "BLK", "STL"];
  var pa = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];
  var pb = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];

  var ppa = [], ppb = [];
  var dt = DateTime.now().toString().split('.')[0];
  var score1 = 0, score2 = 0;

  void logic(i, p) {
    if (freeze == true) return;

    ass = ListQueue.of(pa);
    bss = ListQueue.of(pb);
    ascoress = ListQueue.of(score1.toString().split(""));
    bscoress = ListQueue.of(score2.toString().split(""));
    // bscoress = ListQueue.of(List(score2));

    if (i == 0 || i == 9 || i == 18 || i == 27) {
      return;
    }

    if (p == 1) {
      wss = ListQueue.of(["A"]);
      if (i == 1 ||
          i == 10 ||
          i == 19 ||
          i == 28 ||
          i == 3 ||
          i == 12 ||
          i == 21 ||
          i == 30) {
        pa[i + 1] = pa[i + 1] + 1;
      }

      pa[i] = pa[i] + 1;
      pa[0] = pa[1] * 2 + pa[3] * 3;
      pa[9] = pa[10] * 2 + pa[12] * 3;
      pa[18] = pa[19] * 2 + pa[21] * 3;
      pa[27] = pa[28] * 2 + pa[30] * 3;
      score1 = pa[0] + pa[9] + pa[18] + pa[27];

      setState(() {
        var i = 0;
      });
    } else if (p == 2) {
      wss = ListQueue.of(["B"]);
      if (i == 1 ||
          i == 10 ||
          i == 19 ||
          i == 28 ||
          i == 3 ||
          i == 12 ||
          i == 21 ||
          i == 30) {
        pb[i + 1] = pb[i + 1] + 1;
      }

      pb[i] = pb[i] + 1;
      pb[0] = pb[1] * 2 + pb[3] * 3;
      pb[9] = pb[10] * 2 + pb[12] * 3;
      pb[18] = pb[19] * 2 + pb[21] * 3;
      pb[27] = pb[28] * 2 + pb[30] * 3;
      score2 = pb[0] + pb[9] + pb[18] + pb[27];

      setState(() {});
    }

    if (score1 >= 20 || score2 >= 20) {
      var t = (score1 > score2) ? "A" : "B";
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () {},
              child: AlertDialog(
                title: Text("! Winner !"),
                content: Text(
                  "🏀🏆 Team $t wins 🎉👏",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        freeze = true;
                      });
                      savestate(t);
                    },
                  ),
                ],
              ),
            );
          });
    }
  }

  Future upd(n, d) async {
    await localDB('update', n, 'players', d);
    return;
  }

  void savestate(t) async {
    var game = {
      "dt": dt,
      "statea": pa,
      "stateb": pb,
      "sa": score1,
      "sb": score2,
      "ta": widget.ateamn,
      "tb": widget.bteamn,
    };

    await localDB('add', game, 'games', null);

    var wa = (t == "A") ? 1 : 0;
    var wb = (t == "B") ? 1 : 0;

    //"PTS", "2PM", "2PA", "3PM", "3PA", "REB", "AST", "BLK", "STL"
    widget.ateam[0]["PTS"] = widget.ateam[0]["PTS"] + pa[0];
    widget.ateam[0]["2PM"] = widget.ateam[0]["2PM"] + pa[1];
    widget.ateam[0]["2PA"] = widget.ateam[0]["2PA"] + pa[2];
    widget.ateam[0]["3PM"] = widget.ateam[0]["3PM"] + pa[3];
    widget.ateam[0]["3PA"] = widget.ateam[0]["3PA"] + pa[4];
    widget.ateam[0]["REB"] = widget.ateam[0]["REB"] + pa[5];
    widget.ateam[0]["AST"] = widget.ateam[0]["AST"] + pa[6];
    widget.ateam[0]["BLK"] = widget.ateam[0]["BLK"] + pa[7];
    widget.ateam[0]["STL"] = widget.ateam[0]["STL"] + pa[8];
    widget.ateam[0]["WIN"] = widget.ateam[0]["WIN"] + wa;
    widget.ateam[0]["CNT"] = widget.ateam[0]["CNT"] + 1;

    widget.ateam[1]["PTS"] = widget.ateam[1]["PTS"] + pa[9];
    widget.ateam[1]["2PM"] = widget.ateam[1]["2PM"] + pa[10];
    widget.ateam[1]["2PA"] = widget.ateam[1]["2PA"] + pa[11];
    widget.ateam[1]["3PM"] = widget.ateam[1]["3PM"] + pa[12];
    widget.ateam[1]["3PA"] = widget.ateam[1]["3PA"] + pa[13];
    widget.ateam[1]["REB"] = widget.ateam[1]["REB"] + pa[14];
    widget.ateam[1]["AST"] = widget.ateam[1]["AST"] + pa[15];
    widget.ateam[1]["BLK"] = widget.ateam[1]["BLK"] + pa[16];
    widget.ateam[1]["STL"] = widget.ateam[1]["STL"] + pa[17];
    widget.ateam[1]["WIN"] = widget.ateam[1]["WIN"] + wa;
    widget.ateam[1]["CNT"] = widget.ateam[1]["CNT"] + 1;

    widget.ateam[2]["PTS"] = widget.ateam[2]["PTS"] + pa[18];
    widget.ateam[2]["2PM"] = widget.ateam[2]["2PM"] + pa[19];
    widget.ateam[2]["2PA"] = widget.ateam[2]["2PA"] + pa[20];
    widget.ateam[2]["3PM"] = widget.ateam[2]["3PM"] + pa[21];
    widget.ateam[2]["3PA"] = widget.ateam[2]["3PA"] + pa[22];
    widget.ateam[2]["REB"] = widget.ateam[2]["REB"] + pa[23];
    widget.ateam[2]["AST"] = widget.ateam[2]["AST"] + pa[24];
    widget.ateam[2]["BLK"] = widget.ateam[2]["BLK"] + pa[25];
    widget.ateam[2]["STL"] = widget.ateam[2]["STL"] + pa[26];
    widget.ateam[2]["WIN"] = widget.ateam[2]["WIN"] + wa;
    widget.ateam[2]["CNT"] = widget.ateam[2]["CNT"] + 1;

    widget.ateam[3]["PTS"] = widget.ateam[3]["PTS"] + pa[27];
    widget.ateam[3]["2PM"] = widget.ateam[3]["2PM"] + pa[28];
    widget.ateam[3]["2PA"] = widget.ateam[3]["2PA"] + pa[29];
    widget.ateam[3]["3PM"] = widget.ateam[3]["3PM"] + pa[30];
    widget.ateam[3]["3PA"] = widget.ateam[3]["3PA"] + pa[31];
    widget.ateam[3]["REB"] = widget.ateam[3]["REB"] + pa[32];
    widget.ateam[3]["AST"] = widget.ateam[3]["AST"] + pa[33];
    widget.ateam[3]["BLK"] = widget.ateam[3]["BLK"] + pa[34];
    widget.ateam[3]["STL"] = widget.ateam[3]["STL"] + pa[35];
    widget.ateam[3]["WIN"] = widget.ateam[3]["WIN"] + wa;
    widget.ateam[3]["CNT"] = widget.ateam[3]["CNT"] + 1;

    widget.bteam[0]["PTS"] = widget.bteam[0]["PTS"] + pb[0];
    widget.bteam[0]["2PM"] = widget.bteam[0]["2PM"] + pb[1];
    widget.bteam[0]["2PA"] = widget.bteam[0]["2PA"] + pb[2];
    widget.bteam[0]["3PM"] = widget.bteam[0]["3PM"] + pb[3];
    widget.bteam[0]["3PA"] = widget.bteam[0]["3PA"] + pb[4];
    widget.bteam[0]["REB"] = widget.bteam[0]["REB"] + pb[5];
    widget.bteam[0]["AST"] = widget.bteam[0]["AST"] + pb[6];
    widget.bteam[0]["BLK"] = widget.bteam[0]["BLK"] + pb[7];
    widget.bteam[0]["STL"] = widget.bteam[0]["STL"] + pb[8];
    widget.bteam[0]["WIN"] = widget.bteam[0]["WIN"] + wb;
    widget.bteam[0]["CNT"] = widget.bteam[0]["CNT"] + 1;

    widget.bteam[1]["PTS"] = widget.bteam[1]["PTS"] + pb[9];
    widget.bteam[1]["2PM"] = widget.bteam[1]["2PM"] + pb[10];
    widget.bteam[1]["2PA"] = widget.bteam[1]["2PA"] + pb[11];
    widget.bteam[1]["3PM"] = widget.bteam[1]["3PM"] + pb[12];
    widget.bteam[1]["3PA"] = widget.bteam[1]["3PA"] + pb[13];
    widget.bteam[1]["REB"] = widget.bteam[1]["REB"] + pb[14];
    widget.bteam[1]["AST"] = widget.bteam[1]["AST"] + pb[15];
    widget.bteam[1]["BLK"] = widget.bteam[1]["BLK"] + pb[16];
    widget.bteam[1]["STL"] = widget.bteam[1]["STL"] + pb[17];
    widget.bteam[1]["WIN"] = widget.bteam[1]["WIN"] + wb;
    widget.bteam[1]["CNT"] = widget.bteam[1]["CNT"] + 1;

    widget.bteam[2]["PTS"] = widget.bteam[2]["PTS"] + pb[18];
    widget.bteam[2]["2PM"] = widget.bteam[2]["2PM"] + pb[19];
    widget.bteam[2]["2PA"] = widget.bteam[2]["2PA"] + pb[20];
    widget.bteam[2]["3PM"] = widget.bteam[2]["3PM"] + pb[21];
    widget.bteam[2]["3PA"] = widget.bteam[2]["3PA"] + pb[22];
    widget.bteam[2]["REB"] = widget.bteam[2]["REB"] + pb[23];
    widget.bteam[2]["AST"] = widget.bteam[2]["AST"] + pb[24];
    widget.bteam[2]["BLK"] = widget.bteam[2]["BLK"] + pb[25];
    widget.bteam[2]["STL"] = widget.bteam[2]["STL"] + pb[26];
    widget.bteam[1]["WIN"] = widget.bteam[1]["WIN"] + wb;
    widget.bteam[2]["CNT"] = widget.bteam[2]["CNT"] + 1;

    widget.bteam[3]["PTS"] = widget.bteam[3]["PTS"] + pb[27];
    widget.bteam[3]["2PM"] = widget.bteam[3]["2PM"] + pb[28];
    widget.bteam[3]["2PA"] = widget.bteam[3]["2PA"] + pb[29];
    widget.bteam[3]["3PM"] = widget.bteam[3]["3PM"] + pb[30];
    widget.bteam[3]["3PA"] = widget.bteam[3]["3PA"] + pb[31];
    widget.bteam[3]["REB"] = widget.bteam[3]["REB"] + pb[32];
    widget.bteam[3]["AST"] = widget.bteam[3]["AST"] + pb[33];
    widget.bteam[3]["BLK"] = widget.bteam[3]["BLK"] + pb[34];
    widget.bteam[3]["STL"] = widget.bteam[3]["STL"] + pb[35];
    widget.bteam[1]["WIN"] = widget.bteam[1]["WIN"] + wb;
    widget.bteam[3]["CNT"] = widget.bteam[3]["CNT"] + 1;

    upd(widget.ateam[0]["name"], widget.ateam[0]).then((e) {
      upd(widget.ateam[1]["name"], widget.ateam[1]).then((e) {
        upd(widget.ateam[2]["name"], widget.ateam[2]).then((e) {
          upd(widget.ateam[3]["name"], widget.ateam[3]).then((e) {
            upd(widget.bteam[0]["name"], widget.bteam[0]).then((e) {
              upd(widget.bteam[1]["name"], widget.bteam[1]).then((e) {
                upd(widget.bteam[2]["name"], widget.bteam[2]).then((e) {
                  upd(widget.bteam[3]["name"], widget.bteam[3]).then((e));
                });
              });
            });
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;
    final width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: height * 7, bottom: height * 4),
            child: Text(
              'GAME ' + dt,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                  width: width * 90,
                  // margin: EdgeInsets.only(top: height * 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("       "),
                      Text("PTS"),
                      Text("2PM"),
                      Text("2PA"),
                      Text("3PM"),
                      Text("3PA"),
                      Text("REB"),
                      Text("AST"),
                      Text("BLK"),
                      Text("STL"),
                    ],
                  )),
              MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: Container(
                  width: width * 99,
                  height: height * 26,
                  padding: EdgeInsets.all(5),
                  child: GridView.count(
                    crossAxisCount: 10,
                    childAspectRatio: 1 / 1.1,
                    children: List.generate(40, (i) {
                      if (i == 0 || i == 10 || i == 20 || i == 30) {
                        return Container(
                          margin: EdgeInsets.only(top: height * 2),
                          child: Text(
                            "${widget.ateamn[(i / 10).floor()]}",
                            style: TextStyle(fontSize: 10),
                          ),
                        );
                      }
                      if (i < 10) {
                        return FlatButton(
                          padding: EdgeInsets.all(2),
                          child: Text(
                            "${pa[i - 1]}",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          onPressed: () {
                            logic(i - 1, 1);
                          },
                        );
                      } else if (i < 20) {
                        return FlatButton(
                          padding: EdgeInsets.all(2),
                          child: Text(
                            "${pa[i - 2]}",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          onPressed: () {
                            logic(i - 2, 1);
                          },
                        );
                      } else if (i < 30) {
                        return FlatButton(
                          padding: EdgeInsets.all(2),
                          child: Text(
                            "${pa[i - 3]}",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          onPressed: () {
                            logic(i - 3, 1);
                          },
                        );
                      } else if (i < 40) {
                        return FlatButton(
                          padding: EdgeInsets.all(2),
                          child: Text(
                            "${pa[i - 4]}",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          onPressed: () {
                            logic(i - 4, 1);
                          },
                        );
                      }
                    }),
                  ),
                ),
              )
            ],
          ),

          Container(
            margin: EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.all(3),
            child: Text(
              'TEAM A',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            width: width * 35,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              '$score1',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            // width: width * 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orangeAccent,
            ),
          ),

          Divider(
            color: Colors.black,
          ),

          //  ------------------------------------------------------
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                '$score2',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              // width: width * 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orangeAccent,
                // border: Border.all(
                // color: Colors.black54,
                // )),
              )),

          Container(
            margin: EdgeInsets.only(top: 5, bottom: 10),
            padding: EdgeInsets.all(3),
            child: Text(
              'TEAM B',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            width: width * 35,
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  width: width * 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("       "),
                      Text("PTS"),
                      Text("2PM"),
                      Text("2PA"),
                      Text("3PM"),
                      Text("3PA"),
                      Text("REB"),
                      Text("AST"),
                      Text("BLK"),
                      Text("STL"),
                    ],
                  )),
              MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: Container(
                    // width: MaxColumnWidth,
                    width: width * 99,
                    height: height * 26,
                    padding: EdgeInsets.all(2),
                    child: GridView.count(
                      crossAxisCount: 10,
                      childAspectRatio: 1 / 1.1,
                      children: List.generate(40, (i) {
                        if (i == 0 || i == 10 || i == 20 || i == 30) {
                          return Container(
                            margin: EdgeInsets.only(top: height * 1.5),
                            child: Text(
                              "${widget.bteamn[(i / 10).floor()]}",
                              style: TextStyle(fontSize: 10),
                            ),
                          );
                        }
                        if (i < 10) {
                          return FlatButton(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              "${pb[i - 1]}",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            onPressed: () {
                              logic(i - 1, 2);
                            },
                          );
                        } else if (i < 20) {
                          return FlatButton(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              "${pb[i - 2]}",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            onPressed: () {
                              logic(i - 2, 2);
                            },
                          );
                        } else if (i < 30) {
                          return FlatButton(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              "${pb[i - 3]}",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            onPressed: () {
                              logic(i - 3, 2);
                            },
                          );
                        } else if (i < 40) {
                          return FlatButton(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              "${pb[i - 4]}",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            onPressed: () {
                              logic(i - 4, 2);
                            },
                          );
                        }
                      }),
                    ),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: height * 3,
                width: width * 30,
                child: RaisedButton(
                  color: Colors.red,
                  child: Text(
                    "Home",
                    style: TextStyle(fontSize: 11, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                ),
              ),
              Container(
                height: height * 3,
                width: width * 30,
                child: RaisedButton(
                  color: Colors.amber,
                  child: Text(
                    "Undo",
                    style: TextStyle(fontSize: 11, color: Colors.white),
                  ),
                  onPressed: (freeze == false)
                      ? () {
                          setState(() {
                            if (wss == null) return;
                            if (wss.isEmpty) return;
                            if (List.from(wss)[0] == "A") {
                              pa = List.from(ass);
                              score1 = int.tryParse(List.from(ascoress)[0]);
                            } else if (List.from(wss)[0] == "B") {
                              pb = List.from(bss);
                              score2 = int.tryParse(List.from(bscoress)[0]);
                            }
                          });
                        }
                      : null,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
