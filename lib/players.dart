import 'package:flutter/material.dart';
import 'db.dart';
import 'dart:async';
import 'viewplayer.dart';


class Players extends StatefulWidget {
  @override
  _PlayersState createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  Future getplayers() async {
    var r = await localDB('getall', null, 'players', null);
    print("API CALL $r");
    return r;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
      future: getplayers(),
      builder: (context, snap) {
        if (snap.hasData && snap.connectionState == ConnectionState.done && snap.data.isNotEmpty) {
          // print("yyyyyyyyyyyyyyyyyyyyyeeeeeeeeeeeeeesssssss");
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 60),
                  child: Text(
                  'PLAYERS',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35, color: Colors.blueAccent),
                ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 100 * 70,
                  child: GridView.count(
                    crossAxisCount: 5,
                    children: List.generate(snap.data.length, (i) {
                      return Container(
                        height: 350,
                        child: InkWell(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Image(image: ExactAssetImage("${snap.data[i]["img"]}"), width: 50,),
                            Text("${snap.data[i]['name']}"),
                          ],
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ViewPlayer("${snap.data[i]['name']}"),
                          ));
                          },
                        )
                      );
                    }),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  width: 180,
                  child: RaisedButton.icon(
                    color: Colors.green,
                    textColor: Colors.white,
                    label: Text('Add player'),
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.pushNamed(context, '/newplayer');
                    },
                  ),
                )
              ],
            ),
          );
        } else if (snap.connectionState == ConnectionState.done) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'PLAYERS',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35, color: Colors.blueAccent),
                ),
                Text("🍃 This place is empty", style: TextStyle(fontSize: 25)),
                Container(
                  width: 180,
                  child: RaisedButton.icon(
                    color: Colors.green,
                    textColor: Colors.white,
                    label: Text('Add player'),
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.pushNamed(context, '/newplayer');
                    },
                  ),
                )
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    ));
  }
}
