import 'package:appsmuslim/models/ayaModel.dart';
import 'package:appsmuslim/pages/quran/models/suraModel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class DBHelper {
  static Database _db;

//get database
  Future<Database> get db async {
      if (null != _db) {
        return _db;
      }
      _db = await initDb('quran-uthmani.db','assets/quran-data/quran-uthmani.db');
      return _db;
  }

  initDb(String databaseName, String databasePathBundle) async {
    // Get the Device's Documents directory to store the Offline Database...
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    bool fileExists = io.File(path).existsSync();
    if (!fileExists) {
      // Move checking database dir
      var byteData = await rootBundle.load(databasePathBundle);
      var bytes = byteData.buffer.asUint8List(0, byteData.lengthInBytes);
      await io.File(path).writeAsBytes(bytes);
    }
    Database database = await openDatabase(path);
    return database;
  }

// Method to return all ayas base on sura from the DB
  Future<List<Aya>> getAyas() async {
    var dbClient = await db;
    // specify the column names you want in the result set
    List<Map> maps = await dbClient.query('quran',columns: ['*'] , where: 'sura == 1');

    List<Aya> listAya = [];
     if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        listAya.add(Aya.fromJson(maps[i]));
      }
    }
    return listAya;
  }


//untuk baca json
  Future<String> loadString(String key) async {
    return await rootBundle.loadString(key);
  }

// Get Chapter
  Future<ChaptersModel> getChapters() async {
    String json = await loadString(
      'assets/quran-data/chapters/chapters.en.json',
    );
    var chaptersModel = ChaptersModel.chaptersModelFromJson(json);
    return chaptersModel;
  }

// Method to Close the Database
  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}