import 'package:flutter/material.dart';

class ViewGame extends StatefulWidget {
  var game;
  ViewGame(this.game, {Key key}) : super(key: key);

  @override
  _ViewGameState createState() => _ViewGameState();
}

class _ViewGameState extends State<ViewGame> {
  var cols = ["PTS", "2PM", "2PA", "3PM", "3PA", "REB", "AST", "BLK", "STL"];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;
    final width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      body: (widget.game==null) ? Container(child: CircularProgressIndicator(),):
      Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: height * 7, bottom: height * 4),
            child: Text(
              'GAME ' + widget.game["dt"].toString(),
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
                            widget.game["ta"][(i / 10).floor()],
                            style: TextStyle(fontSize: 10),
                          ),
                        );
                      }
                      if (i < 10) {
                        return FlatButton(
                          padding: EdgeInsets.all(2),
                          child: Text(
                            widget.game["statea"][i - 1].toString(),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          onPressed: () {
                            // logic(i - 1, 1);
                          },
                        );
                      } else if (i < 20) {
                        return FlatButton(
                          padding: EdgeInsets.all(2),
                          child: Text(
                            widget.game["statea"][i - 2].toString(),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          onPressed: () {
                            // logic(i - 2, 1);
                          },
                        );
                      } else if (i < 30) {
                        return FlatButton(
                          padding: EdgeInsets.all(2),
                          child: Text(
                            widget.game["statea"][i - 3].toString(),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          onPressed: () {
                            // logic(i - 3, 1);
                          },
                        );
                      } else if (i < 40) {
                        return FlatButton(
                          padding: EdgeInsets.all(2),
                          child: Text(
                            widget.game["statea"][i - 4].toString(),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          onPressed: () {
                            // logic(i - 4, 1);
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
              widget.game["sa"].toString(),
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
                widget.game["sb"].toString(),
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
                      childAspectRatio: 1,
                      children: List.generate(40, (i) {
                        if (i == 0 || i == 10 || i == 20 || i == 30) {
                          return Container(
                            margin: EdgeInsets.only(top: height * 1.5),
                            child: Text(
                              widget.game["tb"][(i / 10).floor()].toString(),
                              style: TextStyle(fontSize: 10),
                            ),
                          );
                        }
                        if (i < 10) {
                          return FlatButton(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              widget.game["stateb"][i - 1].toString(),
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            onPressed: () {
                              // logic(i - 1, 2);
                            },
                          );
                        } else if (i < 20) {
                          return FlatButton(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              widget.game["stateb"][i - 2].toString(),
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            onPressed: () {
                              // logic(i - 2, 2);
                            },
                          );
                        } else if (i < 30) {
                          return FlatButton(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              widget.game["stateb"][i - 3].toString(),
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            onPressed: () {
                              // logic(i - 3, 2);
                            },
                          );
                        } else if (i < 40) {
                          return FlatButton(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              widget.game["stateb"][i - 4].toString(),
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            onPressed: () {
                              // logic(i - 4, 2);
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
                    "Back",
                    style: TextStyle(fontSize: 11, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}