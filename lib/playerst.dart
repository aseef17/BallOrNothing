import 'db.dart';
import 'package:flutter/material.dart';

class PlayerStats extends StatefulWidget {
  @override
  _PlayerStatsState createState() => _PlayerStatsState();
}

class _PlayerStatsState extends State<PlayerStats> {
  var data = [];
  var j = 0;

  Future getplayers() async {
    var r = await localDB('getall', null, 'players', null);
    print(r);
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

  Widget rowGen(d) {
    print("INTO BUILD $d");
    var l = (d["CNT"]) - d["WIN"];
    print(l);
    print(d["CNT"]);
    print(l);

    var wp = (d["CNT"] != 0) ? (d["WIN"] / d["CNT"]) * 100 : 0;
    var ppg = (d["CNT"] != 0) ? (d["PTS"] / d["CNT"]) * 100 : 0;
    var fg = (d["2PA"] != 0 || d["3PA"] != 0)
        ? (d["2PM"] + d["3PM"]) / (d["2PA"] + d["3PA"]) * 100
        : 0;
    var pp3 = (d["3PA"] != 0) ? (d["3PM"] / d["3PA"]) * 100 : 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 60,
          child: Text(d["name"]),
        ),
        Text(d["WIN"].toString()),
        Text(l.toStringAsFixed(2)),
        Text(wp.toStringAsFixed(2)),
        Text(d["PTS"].toString()),
        Text(ppg.toStringAsFixed(2)),
        Text(fg.toStringAsFixed(2)),
        Text(d["3PM"].toString()),
        Text(pp3.toStringAsFixed(2)),
      ],
    );
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
              margin: EdgeInsets.only(top: 30),
              child: Column(children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        child: Text("PLR",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        onTap: () {
                          print("Yo");
                        },
                      ),
                      InkWell(
                        child: Text("W",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        onTap: () {
                          print("Yo");
                        },
                      ),
                      InkWell(
                        child: Text("L",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        onTap: () {
                          print("Yo");
                        },
                      ),
                      InkWell(
                        child: Text("WIN%",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        onTap: () {
                          print("Yo");
                        },
                      ),
                      InkWell(
                        child: Text("PTS",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        onTap: () {
                          print("Yo");
                        },
                      ),
                      InkWell(
                        child: Text("PPG",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        onTap: () {
                          print("Yo");
                        },
                      ),
                      InkWell(
                        child: Text("FG%",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        onTap: () {
                          print("Yo");
                        },
                      ),
                      InkWell(
                        child: Text("3PM",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        onTap: () {
                          print("Yo");
                        },
                      ),
                      InkWell(
                        child: Text("3P%",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        onTap: () {
                          print("Yo");
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  height: 400,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext ctxt, i) {
                      return Container(
                        // color: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: rowGen(data[i]),
                      );
                    },
                  ),
                )
              ])),
    ));
  }
}
