import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'db.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class NewPlayer extends StatefulWidget {
  var pld;
  NewPlayer(this.pld, {Key key}) : super(key: key);

  @override
  _NewPlayerState createState() => _NewPlayerState();
}

class _NewPlayerState extends State<NewPlayer> {

  // void deleteImg(p) async {
  //   print("CALLED");
  //   final appDocDir = await getApplicationDocumentsDirectory();
  //   var path = appDocDir.path + "/" + p;
  //   var f = File(path);
  //   if (f.existsSync()) {
  //     f.delete();
  //     // print("DELETED $path");
  //     print("CALLED TO DELETE $path");

  //   }
  // }

  String imgp;
  String lab = "CREATE NEW PLAYER";
  var _dex = 0;
  bool namer = false;
  bool edit = false;
  // bool clearImg;
  String filename;
  String path;
  String eors = "SAVE";
  var image;
  var imaged;

  final t1 = TextEditingController();
  final t2 = TextEditingController();
  final t3 = TextEditingController();
  final t4 = TextEditingController();
  final t5 = TextEditingController();
  final t6 = TextEditingController();

  void istack() {
    setState(() {
      _dex = 1;
    });
  }

  void reset() {
    // print("reset state");
    // deleteImg(t1.text);
    setState(() {
      imgp = null;
      image = null;
      _dex = 0;
      namer = false;
      t1.text = "";
      t2.text = "";
      t3.text = "";
      t4.text = "";
      t5.text = "";
      t6.text = "";
      eors = "SAVE";
      edit = false;
      lab = "CREATE NEW PLAYER";
    });
  }

  void editplayer() async {
    if(t1.text.length > 8) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("⚠"),
              content: Text(
                "Name can't be longer than 8 alphabets",
                style: TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
          );

    }

    if (t1.text == "" ||
        t2.text == "" ||
        t3.text == "" ||
        t4.text == "" ||
        t5.text == "" ||
        t6.text == "") {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("⚠"),
              content: Text(
                "Fields can't be empty",
                style: TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
          );
      return;
    }

    var playerobj = {
      "name": "${t1.text}",
      "age": "${t2.text}",
      "height": "${t3.text}",
      "weight": "${t4.text}",
      "strength": "${t5.text}",
      "weakness": "${t6.text}",
      "img": widget.pld[0]["img"],
      "PTS": widget.pld[0]["PTS"],
      "2PM": widget.pld[0]["2PM"],
      "2PA": widget.pld[0]["2PA"],
      "3PM": widget.pld[0]["3PM"],
      "3PA": widget.pld[0]["3PA"],
      "REB": widget.pld[0]["REB"],
      "AST": widget.pld[0]["AST"],
      "BLK": widget.pld[0]["BLK"],
      "STL": widget.pld[0]["STL"],
      "WIN": widget.pld[0]["WIN"],
      "CNT": widget.pld[0]["CNT"],
    };

    await localDB('update', widget.pld[0]["name"], 'players', playerobj);
    // print("Updated");
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void saveplayer() async {
    var r = await localDB("get", t1.text, "players", null);
    if (!r.isEmpty) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("⚠"),
              content: Text(
                "A player with this name already exists",
                style: TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Try again"),
                  onPressed: () {
                    reset();
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
      // clearImg = false;
      return;
    }

    if (t1.text == "" ||
        t2.text == "" ||
        t3.text == "" ||
        t4.text == "" ||
        t5.text == "" ||
        t6.text == "") {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("⚠"),
              content: Text(
                "Fields can't be empty",
                style: TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
      return;
    }

    if (imaged == null) {
      imgp = "images/def.png";
    } else {
      // await image.copy(imgp);
      await imaged.copy(path + "/" + t1.text);
    }
    var playerobj = {
      "name": "${t1.text}",
      "age": "${t2.text}",
      "height": "${t3.text}",
      "weight": "${t4.text}",
      "strength": "${t5.text}",
      "weakness": "${t6.text}",
      "img": "$imgp",
      "PTS": 0,
      "2PM": 0,
      "2PA": 0,
      "3PM": 0,
      "3PA": 0,
      "REB": 0,
      "AST": 0,
      "BLK": 0,
      "STL": 0,
      "WIN": 0,
      "CNT": 0,
    };

    await localDB('add', playerobj, 'players', null);
    // print("Saved");
    Navigator.pop(context);
  }

  void pickImage() async {
    // print("Selecting img");
    // print("Name ${t1.text}");
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final appDocDir = await getApplicationDocumentsDirectory();
    path = appDocDir.path;
    // print("image selected: ${image.path}");
    // await image.copy(path + "/" + t1.text);
    setState(() {
      imgp = path + "/" + t1.text;
      imaged = image; 
      // imgp = path+"/"+t1.text;
      // print("YPYPYP:" + imgp);
      // print(image.path.toString());
    });
    istack();
  }

  void inject() async {
    var cpath = await getApplicationDocumentsDirectory();
    setState(() {
      _dex = 1;
      t1.text = widget.pld[0]["name"].toString();
      t2.text = widget.pld[0]["age"].toString();
      t3.text = widget.pld[0]["height"].toString();
      t4.text = widget.pld[0]["weight"].toString();
      t5.text = widget.pld[0]["strength"].toString();
      t6.text = widget.pld[0]["weakness"].toString();
      // if (widget.pld[0]["img"] == "images/def.png") {
      // image = DefaultAssetBundle.of(context).load('images/def.png');
      // } else {
      image = File(cpath.path + "/" + widget.pld[0]["img"]);
      // }
      edit = true;
      eors = "EDIT";
      lab = "EDIT EXISTING PLAYER";
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.pld == null) {
      // print(widget.pld);
      return;
    } else {
      inject();
    }
  }

  @override
  void dispose() {
    widget.pld = null;
    // print("DISPOSING");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;
    final width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: height * 5),
            child: Text(
              '$lab',
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
                // decoration:
                // BoxDecoration(border: Border.all(color: Colors.black45)),
                child: IndexedStack(
                  alignment: Alignment.center,
                  index: _dex,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.add),
                            color: Colors.amberAccent,
                            shape: CircleBorder(),
                            onPressed:
                                (namer == false) ? null : () => pickImage()),
                        Container(
                          margin: EdgeInsets.only(top: height * 2),
                          child: Text('Add picture'),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: (imgp == "images/def.png" || imgp == null)
                          ? Image.asset('images/def.png')
                          : Image.file(
                              imaged,
                            ),
                      // decoration: BoxDecoration(
                      // image: DecorationImage(
                      // fit: BoxFit.contain, image: ExactAssetImage(imgp)),
                      // ),
                    ),
                  ],
                ),
              ),
              Container(
                height: height * 60,
                width: width * 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: TextField(
                        controller: t1,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: 'NAME'),
                        onChanged: (e) {
                          if (e != "") {
                            setState(() {
                              namer = true;
                            });
                          } else {
                            setState(() {
                              namer = false;
                            });
                          }
                        },
                      ),
                    ),
                    Container(
                      child: TextField(
                        controller: t2,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'AGE'),
                      ),
                    ),
                    Container(
                      child: TextField(
                        controller: t3,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'HEIGHT'),
                      ),
                    ),
                    Container(
                      child: TextField(
                        controller: t4,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'WEIGHT'),
                      ),
                    ),
                    Container(
                      child: TextField(
                        controller: t5,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: 'STRENGTH'),
                      ),
                    ),
                    Container(
                      child: TextField(
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

          // Row for buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: height * 7),
                width: width * 40,
                child: RaisedButton(
                  color: Colors.redAccent,
                  child: Text('RESET', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    reset();
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: height * 7),
                width: width * 40,
                child: RaisedButton(
                  color: Colors.greenAccent,
                  child: Text(
                    eors,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed:
                      (edit == false) ? () => saveplayer() : () => editplayer(),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
