// W - Total Wins
// L - Total Losses
// WIN% - Win % ( matches won / matches played )
// PTS - Total Points
// PPG - points per game (total points / total games played)
// FG% - field goal % ( 2 pointers and 3 pointers are collectively called field goals. - FG% is total made field goals/total attempted field goals )
// 3PM - Total 3 pointers made
// 3P% -  3 point % (total 3 pointers made / total 3 pointers attempted)

import 'db.dart';
import 'package:flutter/material.dart';

class PlayerStats extends StatefulWidget {
  @override
  _PlayerStatsState createState() => _PlayerStatsState();
}

class _PlayerStatsState extends State<PlayerStats> {
  var data = [];
  var j=0;

  Future getplayers() async {
    var r = await localDB('getall', null, 'players', null);
    return r;
  }

  @override
  void initState() {
    getplayers().then((e) {
      setState(() {
        data.addAll(e);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: (data == null || data.isEmpty)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
            margin: EdgeInsets.only(top: 90),
              child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("PLR"),
                  Text("W"),
                  Text("L"),
                  Text("WIN%"),
                  Text("PTS"),
                  Text("PPG"),
                  Text("FG%"),
                  Text("3PM"),
                  Text("3P%"),
                ],
              ),
              Container(
                height: 400,
                child: Column(
                  children: <Widget>[
                    
                  ],
                )
              )
            ])),
    ));
  }
}
