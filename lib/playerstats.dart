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
    return r;
  }

  var nc = 0;

  void calcInject() {
    for (int i = 0; i < data.length; i++) {
      var l = (data[i]["CNT"]) - data[i]["WIN"];
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

      data[i]["l"] = l;
      data[i]["wp"] = num.parse(wp.toStringAsFixed(2));
      data[i]["ppg"] = num.parse(ppg.toStringAsFixed(2));
      data[i]["fg"] = num.parse(fg.toStringAsFixed(2));
      data[i]["pp3"] = num.parse(pp3.toStringAsFixed(2));
    }
  }

  List<DataRow> rowGen(d) {
    var dr;
    List<DataRow> mdr = [];
    for (int i = 0; i < d.length; i++) {
      dr = DataRow(cells: [
        DataCell(
          Text("${i + 1}. " + d[i]["name"]),
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
        });
      } else {
        setState(() {
          data.sort((a, b) => b["name"].compareTo(a["name"]));
        });
      }
    } else if (ci == 1) {
      if (ascending) {
        setState(() {
          data.sort((a, b) => a["WIN"].compareTo(b["WIN"]));
        });
      } else {
        setState(() {
          data.sort((a, b) => b["WIN"].compareTo(a["WIN"]));
        });
      }
    } else if (ci == 2) {
      if (ascending) {
        setState(() {
          data.sort((a, b) => a["l"].compareTo(b["l"]));
        });
      } else {
        setState(() {
          data.sort((a, b) => b["l"].compareTo(a["l"]));
        });
      }
    } else if (ci == 3) {
      if (ascending) {
        setState(() {
          data.sort((a, b) => a["wp"].compareTo(b["wp"]));
        });
      } else {
        setState(() {
          data.sort((a, b) => b["wp"].compareTo(a["wp"]));
        });
      }
    } else if (ci == 4) {
      if (ascending) {
        setState(() {
          data.sort((a, b) => a["PTS"].compareTo(b["PTS"]));
        });
      } else {
        setState(() {
          data.sort((a, b) => b["PTS"].compareTo(a["PTS"]));
        });
      }
    } else if (ci == 5) {
      if (ascending) {
        setState(() {
          data.sort((a, b) => a["ppg"].compareTo(b["ppg"]));
        });
      } else {
        setState(() {
          data.sort((a, b) => b["ppg"].compareTo(a["ppg"]));
        });
      }
    } else if (ci == 6) {
      ;

      if (ascending) {
        setState(() {
          data.sort((a, b) => a["fg"].compareTo(b["fg"]));
        });
      } else {
        setState(() {
          data.sort((a, b) => b["fg"].compareTo(a["fg"]));
        });
      }
    } else if (ci == 7) {
      if (ascending) {
        setState(() {
          data.sort((a, b) => a["3PM"].compareTo(b["3PM"]));
        });
      } else {
        setState(() {
          data.sort((a, b) => b["3PM"].compareTo(a["3PM"]));
        });
      }
    } else if (ci == 8) {
      if (ascending) {
        setState(() {
          data.sort((a, b) => a["pp3"].compareTo(b["pp3"]));
        });
      } else {
        setState(() {
          data.sort((a, b) => b["pp3 "].compareTo(a["pp3"]));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;
    final width = MediaQuery.of(context).size.width / 100;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: (data.isEmpty)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: height*7),
                  child: Text(
                    'PLAYERS STATS',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 35, color: Colors.blueAccent),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    'Scroll 👉 for more fields',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Container(
                    height: height*80,
                    child: ListView(
                      children: <Widget>[
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            sortAscending: sort,
                            sortColumnIndex: nc,
                            columns: [
                              DataColumn(
                                  label: Text("PLAYER"),
                                  numeric: false,
                                  onSort: (ci, ascending) {
                                    setState(() {
                                      sort = !sort;
                                      nc = 0;
                                    });
                                    sortColum(ci, ascending);
                                  }),
                              DataColumn(
                                  label: Text("W"),
                                  numeric: true,
                                  onSort: (ci, ascending) {
                                    setState(() {
                                      sort = !sort;
                                      nc = 1;
                                    });
                                    sortColum(ci, ascending);
                                  }),
                              DataColumn(
                                  label: Text("L"),
                                  numeric: true,
                                  onSort: (ci, ascending) {
                                    setState(() {
                                      sort = !sort;
                                      nc = 2;
                                    });
                                    sortColum(ci, ascending);
                                  }),
                              DataColumn(
                                  label: Text("WIN%"),
                                  numeric: true,
                                  onSort: (ci, ascending) {
                                    setState(() {
                                      sort = !sort;
                                      nc = 3;
                                    });
                                    sortColum(ci, ascending);
                                  }),
                              DataColumn(
                                  label: Text("PTS"),
                                  numeric: true,
                                  onSort: (ci, ascending) {
                                    setState(() {
                                      sort = !sort;
                                      nc = 4;
                                    });
                                    sortColum(ci, ascending);
                                  }),
                              DataColumn(
                                  label: Text("PPG"),
                                  numeric: true,
                                  onSort: (ci, ascending) {
                                    setState(() {
                                      sort = !sort;
                                      nc = 5;
                                    });
                                    sortColum(ci, ascending);
                                  }),
                              DataColumn(
                                  label: Text("FG%"),
                                  numeric: true,
                                  onSort: (ci, ascending) {
                                    setState(() {
                                      sort = !sort;
                                      nc = 6;
                                    });
                                    sortColum(ci, ascending);
                                  }),
                              DataColumn(
                                  label: Text("3PM"),
                                  numeric: true,
                                  onSort: (ci, ascending) {
                                    setState(() {
                                      sort = !sort;
                                      nc = 7;
                                    });
                                    sortColum(ci, ascending);
                                  }),
                              DataColumn(
                                  label: Text("3P%"),
                                  numeric: true,
                                  onSort: (ci, ascending) {
                                    setState(() {
                                      sort = !sort;
                                      nc = 8;
                                    });
                                    sortColum(ci, ascending);
                                  })
                            ],
                            rows: rowGen(data),
                          ),
                        ),
                      ],
                    )),

                // Expanded(
                //       child: Align(
                //         alignment: Alignment.bottomCenter,
                //         child: Container(
                //           margin: EdgeInsets.only(bottom: 30),
                //           child: RaisedButton(
                //             color: Colors.blue,
                //             padding:
                //                 EdgeInsets.symmetric(horizontal: 95, vertical: 15),
                //             child: Text(
                //               'BACK',
                //               style: TextStyle(color: Colors.white),
                //             ),
                //             onPressed: () {
                //               Navigator.pop(context);
                //             },
                //           ),
                //         ),
                //       ),
                //     )
              ],
            )),
    );
  }
}
