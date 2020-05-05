
import 'package:appsmuslim/pages/waktu/model/waktuModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class WaktuSolatDataService {
  Database database;

  String _table = 'waktusolat';
  
  Future init() async {
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, 'waktusolat.db');
    if (database == null) {
      database = await openDatabase(
        path,
        onConfigure: (d) {
          d.execute(
            'CREATE TABLE if not exists `$_table` (`id`	INTEGER PRIMARY KEY AUTOINCREMENT, `nama_solat`	TEXT )',
          );
        },
      );
    }
  }

  Future<List<WaktuNotification>> getlistNotif() async {
    await init();
    var listWaktuNotif = await database.query(
      _table,
      columns: ['*'],
    );
    List<WaktuNotification> listWaktus = listWaktuNotif.map(
      (v) {
        return WaktuNotification.fromJson(v);
      },
    ).toList();
    return listWaktus;
  }

  Future<int> add(WaktuNotification waktunotifmodel) async {
    await init();
    int id = await database.insert(_table, waktunotifmodel.toJson());
    return id;
  }

  Future<bool> delete(String waktumodelid) async {
    await init();
    int i = await database.delete(
      _table,
      where: 'nama_solat = ?',
      whereArgs: [
        waktumodelid,
      ],
    );
    return i == 1;
  }

  void dispose() {
    database.close();
    database = null;
  }
}
