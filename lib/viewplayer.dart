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
    // print("Output $r ENDS");
    // print(r[0]['age']);
    return r;
  }
  void deleteImg(p) async {
    print("CALLED");
    final appDocDir = await getApplicationDocumentsDirectory();
    var path = appDocDir.path + "/" + p;
    var f = File(path);
    if (f.existsSync()) {
      f.delete();
      // print("CALLED TO DELETE $path");
      // print("DELETED $path");
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;
    final width = MediaQuery.of(context).size.width / 100;

    return Scaffold(
        body: FutureBuilder(
      future: getplayer(widget.name),
      builder: (context, snap) {
        if (snap.hasData &&
            snap.connectionState == ConnectionState.done &&
            snap.data.isNotEmpty) {
          t1.text = snap.data[0]["name"].toString();
          t2.text = snap.data[0]["age"].toString();
          t3.text = snap.data[0]["height"].toString();
          t4.text = snap.data[0]["weight"].toString();
          t5.text = snap.data[0]["strength"].toString();
          t6.text = snap.data[0]["weakness"].toString();
          image = snap.data[0]["img"].toString();
          print("VV img $image");

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
                      width: width * 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
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
                  Container(
                      margin: EdgeInsets.only(top: height * 2),
                      width: width * 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text("${snap.data[0]['PTS']}"),
                          Text("${snap.data[0]['2PM']}"),
                          Text("${snap.data[0]['2PA']}"),
                          Text("${snap.data[0]['3PM']}"),
                          Text("${snap.data[0]['3PA']}"),
                          Text("${snap.data[0]['REB']}"),
                          Text("${snap.data[0]['AST']}"),
                          Text("${snap.data[0]['BLK']}"),
                          Text("${snap.data[0]['STL']}"),
                        ],
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: height * 7),
                    width: width * 40,
                    child: RaisedButton(
                      color: Colors.redAccent,
                      child:
                          Text('DELETE', style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        await localDB('delete', widget.name, 'players', null);    
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
                              builder: (context) =>
                                  NewPlayer(snap.data),
                            ));
                      },
                    ),
                  )
                ],
              )
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
