import 'db.dart';
import 'package:flutter/material.dart';

class PlayerStats extends StatefulWidget {
  @override
  _PlayerStatsState createState() => _PlayerStatsState();
}

class _PlayerStatsState extends State<PlayerStats> {
  var data = [];

  Future getplayers() async {
    var r = await localDB('getall', null, 'players', null);
    print("WHY CALL ME");
    return r;
  }

  void calcInject() {
    for (int i = 0; i < data.length; i++) {
      var l = (data[i]["CNT"]) - data[i]["WIN"];

      var wp =
          (data[i]["CNT"] != 0) ? (data[i]["WIN"] / data[i]["CNT"]) * 100 : 0;
      var ppg =
          (data[i]["CNT"] != 0) ? (data[i]["PTS"] / data[i]["CNT"]) : 0;
      var fg = (data[i]["2PA"] != 0 || data[i]["3PA"] != 0)
          ? (data[i]["2PM"] + data[i]["3PM"]) /
              (data[i]["2PA"] + data[i]["3PA"]) *
              100
          : 0;
      var pp3 =
          (data[i]["3PA"] != 0) ? (data[i]["3PM"] / data[i]["3PA"]) * 100 : 0;

      data[i]["l"] = l;
      data[i]["wp"] = wp;
      data[i]["ppg"] = ppg;
      data[i]["fg"] = fg;
      data[i]["pp3"] = pp3;
    }
  }

  List<DataRow> rowGen(d) {
    var dr;
    List<DataRow> mdr = [];
    for (int i = 0; i < d.length; i++) {
      dr = DataRow(cells: [
        DataCell(
          Text(d[i]["name"]),
        ),
        DataCell(
          Text(d[i]["WIN"].toString()),
        ),
        DataCell(Text(
          (d[i]["l"].toStringAsFixed(2)),
        )),
        DataCell(Text(
          (d[i]["wp"].toStringAsFixed(2)),
        )),
        DataCell(
          Text(d[i]["PTS"].toString()),
        ),
        DataCell(Text(
          (d[i]["ppg"].toStringAsFixed(2)),
        )),
        DataCell(
          Text(d[i]["fg"].toStringAsFixed(2)),
        ),
        DataCell(
          Text(d[i]["3PM"].toString()),
        ),
        DataCell(
          Text(d[i]["pp3"].toStringAsFixed(2)),
        ),
      ]);
      mdr.add(dr);
    }
    return mdr;
  }

  bool sort;

  @override
  void initState() {
    sort = false;
    getplayers().then((e) {
      setState(() {
        data.addAll(e);
        calcInject();
      });
    });
    super.initState();
  }

  sortColum(int ci, bool ascending) {
    if (ci == 0) {
      if (ascending) {
        setState(() {
          data.sort((a, b) => a["name"].compareTo(b["name"]));
          print(data);
        });
      } else {
        setState(() {
          data.sort((a, b) => b["name"].compareTo(a["name"]));
          print(data);
        });
      }
    } else if (ci == 1) {
      if (ascending) {
        setState(() {
          data.sort((a, b) => a["l"].compareTo(b["l"]));
          print(data);
        });
      } else {
        setState(() {
          data.sort((a, b) => b["l"].compareTo(a["l"]));
          print(data);
        });
      }
    } else if (ci == 2) {
      if (ascending) {
        setState(() {
          data.sort((a, b) => a["wp"].compareTo(b["wp"]));
          print(data);
        });
      } else {
        setState(() {
          data.sort((a, b) => b["wp"].compareTo(a["wp"]));
          print(data);
        });
      }
    } else if (ci == 3) {
      if (ascending) {
        setState(() {
          data.sort((a, b) => a["PTS"].compareTo(b["PTS"]));
          print(data);
        });
      } else {
        setState(() {
          data.sort((a, b) => b["PTS"].compareTo(a["PTS"]));
          print(data);
        });
      }
    } else if (ci == 4) {
      if (ascending) {
        setState(() {
          data.sort((a, b) => a["ppg"].compareTo(b["ppg"]));
          print(data);
        });
      } else {
        setState(() {
          data.sort((a, b) => b["ppg"].compareTo(a["ppg"]));
          print(data);
        });
      }
    } else if (ci == 5) {
      if (ascending) {
        setState(() {
          data.sort((a, b) => a["fg"].compareTo(b["fg"]));
          print(data);
        });
      } else {
        setState(() {
          data.sort((a, b) => b["fg"].compareTo(a["fg"]));
          print(data);
        });
      }
    } else if (ci == 6) {
      if (ascending) {
        setState(() {
          data.sort((a, b) => a["3pm"].compareTo(b["3pm"]));
          print(data);
        });
      } else {
        setState(() {
          data.sort((a, b) => b["3pm"].compareTo(a["3pm"]));
          print(data);
        });
      }
    } else if (ci == 7) {
      if (ascending) {
        setState(() {
          data.sort((a, b) => a["pp3"].compareTo(b["pp3"]));
          print(data);
        });
      } else {
        setState(() {
          data.sort((a, b) => b["pp3"].compareTo(a["pp3"]));
          print(data);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: (data.isEmpty)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: <Widget>[
                  Container(
                  margin: EdgeInsets.only(top: 60, bottom: 30),
                  child: Text(
                    'PLAYERS STATS',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 35, color: Colors.blueAccent),
                  ),
                ),
                   Container(
                     height: height * 0.73,
                  child: ListView(
              children: <Widget>[
                
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    sortAscending: sort,
                    sortColumnIndex: 1,
                    columns: [
                      DataColumn(
                          label: Text("PLAYER"),
                          numeric: false,
                          onSort: (ci, ascending) {
                            setState(() {
                              sort = !sort;
                            });
                            sortColum(ci, ascending);
                          }),
                      DataColumn(
                          label: Text("W"),
                          numeric: true,
                          onSort: (ci, ascending) {
                            setState(() {
                              sort = !sort;
                            });
                            sortColum(ci, ascending);
                          }),
                      DataColumn(
                          label: Text("L"),
                          numeric: true,
                          onSort: (ci, ascending) {
                            setState(() {
                              sort = !sort;
                            });
                            sortColum(ci, ascending);
                          }),
                      DataColumn(
                          label: Text("WIN%"),
                          numeric: true,
                          onSort: (ci, ascending) {
                            setState(() {
                              sort = !sort;
                            });
                            sortColum(ci, ascending);
                          }),
                      DataColumn(
                          label: Text("PTS"),
                          numeric: true,
                          onSort: (ci, ascending) {
                            setState(() {
                              sort = !sort;
                            });
                            sortColum(ci, ascending);
                          }),
                      DataColumn(
                          label: Text("PPG"),
                          numeric: true,
                          onSort: (ci, ascending) {
                            setState(() {
                              sort = !sort;
                            });
                            sortColum(ci, ascending);
                          }),
                      DataColumn(
                          label: Text("FG%"),
                          numeric: true,
                          onSort: (ci, ascending) {
                            setState(() {
                              sort = !sort;
                            });
                            sortColum(ci, ascending);
                          }),
                      DataColumn(
                          label: Text("3PM"),
                          numeric: true,
                          onSort: (ci, ascending) {
                            setState(() {
                              sort = !sort;
                            });
                            sortColum(ci, ascending);
                          }),
                      DataColumn(
                          label: Text("3P%"),
                          numeric: true,
                          onSort: (ci, ascending) {
                            setState(() {
                              sort = !sort;
                            });
                            sortColum(ci, ascending);
                          })
                    ],
                    rows: rowGen(data),
                  ),
                ),
                
              ],
            )
            ),
            Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: height*0.01),
                      child: RaisedButton(
                        color: Colors.blue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 95, vertical: 15),
                        child: Text(
                          'BACK',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                )

                ],
              )
            ),
    );
  }
}
