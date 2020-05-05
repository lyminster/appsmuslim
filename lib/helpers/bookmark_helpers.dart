import 'package:appsmuslim/pages/quran/models/bookmarksModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BookmarksDataService {
  Database database;

  String _table = 'bookmarks';
  String _tableFolder = 'tablebooks';
  String _tableLast = 'lastseen';

  Future init() async {
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, 'bookmarks.db');
    if (database == null) {
      database = await openDatabase(
        path,
        onConfigure: (d) {
          d.execute(
            'CREATE TABLE if not exists `$_table` (`id`	INTEGER PRIMARY KEY AUTOINCREMENT, `sura`	INTEGER, `sura_name`	TEXT, `aya`	INTEGER, `jenis`	TEXT, `nama_folder`	TEXT ,`juz_number` INTEGER , `insert_time`	TEXT )',
          );
          d.execute(
              'CREATE TABLE if not exists `$_tableFolder` (`id`	INTEGER PRIMARY KEY AUTOINCREMENT, `nama_folder`	TEXT ,`insert_time`	TEXT )');
          d.execute(
            'CREATE TABLE if not exists `$_tableLast` (`id`	INTEGER PRIMARY KEY AUTOINCREMENT, `sura`	INTEGER, `sura_name`	TEXT, `aya`	INTEGER, `jenis`	TEXT, `nama_folder`	TEXT ,`juz_number` INTEGER , `insert_time`	TEXT )',
          );
        },
      );
    }
  }

  Future<List<BookmarksModel>> getLast() async {
    await init();
    var listBookmarksMap = await database.query(
      _tableLast,
      columns: ['*'],
    );
    List<BookmarksModel> listBookmarks = listBookmarksMap.map(
      (v) {
        return BookmarksModel.fromJson(v);
      },
    ).toList();
    return listBookmarks;
  }

  Future<List<BookmarksModel>> getListBookmarks() async {
    await init();
    var listBookmarksMap = await database.query(
      _table,
      columns: ['*'],
    );
    List<BookmarksModel> listBookmarks = listBookmarksMap.map(
      (v) {
        return BookmarksModel.fromJson(v);
      },
    ).toList();
    return listBookmarks;
  }

  Future<List<BookmarksModel>> getListBookmarkswhere(String namaFolder) async {
    await init();
    var listBookmarksMap = await database.query(
      _table,
      columns: ['*'],
      where: 'nama_folder == "$namaFolder"',
    );
    List<BookmarksModel> listBookmarks = listBookmarksMap.map(
      (v) {
        return BookmarksModel.fromJson(v);
      },
    ).toList();
    return listBookmarks;
  }

  Future<List<BookmarkFolder>> getListfolder() async {
    await init();
    var listBookmarksMap = await database.query(
      _tableFolder,
      columns: ['*'],
    );
    List<BookmarkFolder> listBookmarks = listBookmarksMap.map(
      (v) {
        return BookmarkFolder.fromJson(v);
      },
    ).toList();
    return listBookmarks;
  }

  Future<int> addLast(BookmarksModel bookmarkModel) async {
    await init();
    var cekdata = await database.delete(_tableLast);

    int id;
    id = await database.insert(_tableLast, bookmarkModel.toJson());
    
    return id;
  }

  Future<int> add(BookmarksModel bookmarkModel) async {
    await init();
    var cekdata = await database.query(_table,
    columns: ['*'],
    where: 'aya = "${bookmarkModel.aya}" and sura = "${bookmarkModel.sura}" and nama_folder = "${bookmarkModel.namaFolder}"');

    int id;
    if(cekdata.length == 0 ){
      id = await database.insert(_table, bookmarkModel.toJson());
    }
    return id;
  }

  Future<int> addnewfolder(BookmarkFolder bookmarkModel) async {
    await init();
    int id = await database.insert(_tableFolder, bookmarkModel.toJson());
    return id;
  }

  Future<int> updatefolder(String namafolder, int id) async {
    await init();
    // int did = await database.update(_tableFolder, bookmarkModel.toJson(),where: 'id == $id',);
    int did = await database.rawUpdate('UPDATE $_tableFolder set nama_folder = "$namafolder" WHERE id = $id');
    return did;
  }

  Future<bool> delete(int bookmarksModelId) async {
    await init();
    int i = await database.delete(
      _table,
      where: 'id = ?',
      whereArgs: [
        bookmarksModelId,
      ],
    );
    return i == 1;
  }

  Future<bool> deleteIsiFolder(String namaFolder) async {
    await init();
    int i = await database.delete(
      _table,
      where: 'nama_folder = ?',
      whereArgs: [
        namaFolder,
      ],
    );
    return i == 1;
  }

  Future<bool> deletefolder(int bookmarksModelId,String namaFolder) async {
    await init();
    int i = await database.delete(
      _tableFolder,
      where: 'id = ?',
      whereArgs: [
        bookmarksModelId,
      ],
    );
    int a = await database.delete(
      _table,
      where: 'nama_folder = ?',
      whereArgs: [
        namaFolder,
      ],
    );
    return i == 1;
  }

  void dispose() {
    database.close();
    database = null;
  }
}
