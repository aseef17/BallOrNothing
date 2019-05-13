import 'package:flutter/material.dart';
import 'db.dart';
import 'dart:async';
import 'viewplayer.dart';
import 'package:flutter/services.dart';

class Players extends StatefulWidget {
  @override
  _PlayersState createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  Future getplayers() async {
    var r = await localDB('getall', null, 'players', null);
    return r;
  }

  @override
  void initState() {
    imageCache.clear();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: FutureBuilder(
          future: getplayers(),
          builder: (context, snap) {
            if (snap.hasData &&
                snap.connectionState == ConnectionState.done &&
                snap.data.isNotEmpty) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      child: Text(
                        'PLAYERS',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 35, color: Colors.blueAccent),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 100 * 77,
                      child: GridView.count(
                        crossAxisCount: 5,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 25,
                        children: List.generate(snap.data.length, (i) {
                          return Container(
                              height: 380,
                              child: InkWell(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Image(
                                      image: ExactAssetImage(
                                          "${snap.data[i]["img"]}"),
                                      width: 40,
                                    ),
                                    Text("${snap.data[i]['name']}"),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewPlayer(
                                            "${snap.data[i]['name']}"),
                                      ));
                                },
                              ));
                        }),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
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
                    Text("Empty", style: TextStyle(fontSize: 25)),
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
            else if (snap.connectionState == ConnectionState.active ||
                snap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } 
            else {
              return Container();
            }
          },
        ));
  }
}
