import 'package:flutter/material.dart';
import 'newplayer.dart';
import 'db.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ViewPlayer extends StatefulWidget {
  final String name;
  ViewPlayer(this.name, {Key key}) : super(key: key);

  @override
  _ViewPlayerState createState() => _ViewPlayerState();
}

class _ViewPlayerState extends State<ViewPlayer> {
  String image = 'images/def.png';

  final t1 = TextEditingController();
  final t2 = TextEditingController();
  final t3 = TextEditingController();
  final t4 = TextEditingController();
  final t5 = TextEditingController();
  final t6 = TextEditingController();

  Future getplayer(n) async {
    var r = await localDB('get', n, 'players', null);
    return r;
  }

  void deleteImg(p) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    var path = appDocDir.path + "/" + p;
    var f = File(path);
    if (f.existsSync()) {
      f.delete();
    }
  }

  calcInject(data) {
    var i = 0;
    var l = (data[i]["CNT"]) - data[i]["WIN"];
    if (l < 0) l = 0;
    var wp =
        (data[i]["CNT"] != 0) ? (data[i]["WIN"] / data[i]["CNT"]) * 100 : 0;
    var ppg = (data[i]["CNT"] != 0) ? (data[i]["PTS"] / data[i]["CNT"]) : 0;
    var fg = (data[i]["2PA"] != 0 || data[i]["3PA"] != 0)
        ? (data[i]["2PM"] + data[i]["3PM"]) /
            (data[i]["2PA"] + data[i]["3PA"]) *
            100
        : 0;
    var pp3 =
        (data[i]["3PA"] != 0) ? (data[i]["3PM"] / data[i]["3PA"]) * 100 : 0;
    if (pp3 != 0) {
      pp3 = num.parse(pp3.toStringAsFixed(2));
    }
    data[i]["l"] = l.floor();
    data[i]["wp"] = num.parse(wp.toStringAsFixed(2));
    data[i]["ppg"] = num.parse(ppg.toStringAsFixed(2));
    data[i]["fg"] = num.parse(fg.toStringAsFixed(2));
    data[i]["pp3"] = pp3;
    return data;
  }

  @override
  Widget build(BuildContext context) {
    var data2;

    final height = MediaQuery.of(context).size.height / 100;
    final width = MediaQuery.of(context).size.width / 100;

    return Scaffold(
        body: FutureBuilder(
      future: getplayer(widget.name),
      builder: (context, snap) {
        if (snap.hasData &&
            snap.connectionState == ConnectionState.done &&
            snap.data.isNotEmpty) {
          data2 = calcInject(snap.data);
          t1.text = snap.data[0]["name"].toString();
          t2.text = snap.data[0]["age"].toString();
          t3.text = snap.data[0]["height"].toString();
          t4.text = snap.data[0]["weight"].toString();
          t5.text = snap.data[0]["strength"].toString();
          t6.text = snap.data[0]["weakness"].toString();
          image = snap.data[0]["img"].toString();

          return ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: height * 5),
                child: Text(
                  "Player",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue,
                  ),
                ),
              ),
              // Row for img & info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      height: height * 60,
                      width: width * 40,
                      child: Image.asset(
                        image,
                        fit: BoxFit.contain,
                      )),
                  Container(
                    height: height * 60,
                    width: width * 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: TextField(
                            enabled: false,
                            controller: t1,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(labelText: 'NAME'),
                            // enabled: false,
                          ),
                        ),
                        Container(
                          child: TextField(
                            enabled: false,
                            controller: t2,
                            // enabled: false,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: 'AGE'),
                          ),
                        ),
                        Container(
                          child: TextField(
                            enabled: false,
                            controller: t3,
                            // enabled: false,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: 'HEIGHT'),
                          ),
                        ),
                        Container(
                          child: TextField(
                            enabled: false,
                            controller: t4,
                            // enabled: false,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: 'WEIGHT'),
                          ),
                        ),
                        Container(
                          child: TextField(
                            enabled: false,
                            controller: t5,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(labelText: 'STRENGTH'),
                          ),
                        ),
                        Container(
                          child: TextField(
                            enabled: false,
                            controller: t6,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(labelText: 'WEAKNESS'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: height * 2),
                    width: width * 90,
                    child: Table(
                      children: [
                        TableRow(children: [
                          TableCell(
                              child: Padding(
                            child: Text("W"),
                            padding: EdgeInsets.only(top: 5),
                          )),
                          TableCell(
                            child: Padding(
                              child: Text("L"),
                              padding: EdgeInsets.only(top: 5),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              child: Text("FG%"),
                              padding: EdgeInsets.only(top: 5),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              child: Text("3PM"),
                              padding: EdgeInsets.only(top: 5),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              child: Text("3PA"),
                              padding: EdgeInsets.only(top: 5),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              child: Text("REB"),
                              padding: EdgeInsets.only(top: 5),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              child: Text("AST"),
                              padding: EdgeInsets.only(top: 5),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              child: Text("BLK"),
                              padding: EdgeInsets.only(top: 5),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              child: Text("STL"),
                              padding: EdgeInsets.only(top: 5),
                            ),
                          )
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: Padding(
                              child: Text(data2[0]["WIN"].toString()),
                              padding: EdgeInsets.only(top: 5),
                            ),
                          ),
                          TableCell(
                              child: Padding(
                            child: Text(data2[0]["l"].toString()),
                            padding: EdgeInsets.only(top: 5),
                          )),
                          TableCell(
                              child: Padding(
                            child: Text(data2[0]['fg'].toString()),
                            padding: EdgeInsets.only(top: 5),
                          )),
                          TableCell(
                              child: Padding(
                            child: Text("${snap.data[0]['3PM']}"),
                            padding: EdgeInsets.only(top: 5),
                          )),
                          TableCell(
                              child: Padding(
                            child: Text("${snap.data[0]['3PA']}"),
                            padding: EdgeInsets.only(top: 5),
                          )),
                          TableCell(
                              child: Padding(
                            child: Text("${snap.data[0]['REB']}"),
                            padding: EdgeInsets.only(top: 5),
                          )),
                          TableCell(
                              child: Padding(
                            child: Text("${snap.data[0]['AST']}"),
                            padding: EdgeInsets.only(top: 5),
                          )),
                          TableCell(
                              child: Padding(
                            child: Text("${snap.data[0]['BLK']}"),
                            padding: EdgeInsets.only(top: 5),
                          )),
                          TableCell(
                              child: Padding(
                            child: Text("${snap.data[0]['STL']}"),
                            padding: EdgeInsets.only(top: 5),
                          ))
                        ]),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: height * 7),
                        width: width * 40,
                        child: RaisedButton(
                          color: Colors.redAccent,
                          child: Text('DELETE',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                            await localDB(
                                'delete', widget.name, 'players', null);
                            deleteImg(widget.name);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: height * 7),
                        width: width * 40,
                        child: RaisedButton(
                          color: Colors.greenAccent,
                          child: Text(
                            'EDIT',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewPlayer(snap.data),
                                ));
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          );
        } else if (snap.connectionState == ConnectionState.done) {
          return Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text('404 🍳 Guru meditation'),
              ));
        }
        return Center(child: CircularProgressIndicator());
      },
    ));
  }
}
