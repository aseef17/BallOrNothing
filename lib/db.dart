import 'package:path_provider/path_provider.dart';
import 'package:objectdb/objectdb.dart';

localDB(req, data, slot, ndata) async {

  var cpath = await getApplicationDocumentsDirectory();
  String dbPath = cpath.path+'$slot.db';
  var db = ObjectDB(dbPath);
  await db.open();
  switch (req) {

    case "add":
      await db.insert(data);
    break;

    case "get":
      var res = await db.find({"name":data});
      return res;
    break;

    case "getall":
     var res = await db.find({});
      return res;
    break;

    case "update":
      await db.update({"name":data}, ndata, true);
      // print("updting");
    break;

    case "delete":
      await db.remove({'name': data});
    break;

  }  
}
