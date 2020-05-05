import 'package:appsmuslim/helpers/bookmark_helpers.dart';
import 'package:appsmuslim/helpers/trans_helpers.dart';
import 'package:appsmuslim/pages/quran/models/ayaModel.dart';
import 'package:appsmuslim/pages/quran/models/bookmarksModel.dart';
import 'package:appsmuslim/pages/quran/models/juzModel.dart';
import 'package:appsmuslim/pages/quran/models/suraModel.dart';
import 'package:appsmuslim/pages/quran/models/transModel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;


class DBHelper {
  static Database _db;
  JuzModel _juzModel;

//get database
  Future<Database> get db async {
    _db = null;
    if (null != _db) {
      return _db;
    }
    _db =
        await initDb('quran-uthmani.db', 'assets/quran-data/quran-uthmani.db');
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
  Future<List<Aya>> getAyas(int sura) async {
    var dbClient = await db;
    // specify the column names you want in the result set
    var listAyaMap = await dbClient.query(
      'quran_id',
      columns:  ['*'],
      where: 'suraId == "$sura"',
    );
    var listAya = listAyaMap.map((v) {
      var aya = Aya.fromJson(v);
      return aya;
    });
    return listAya.toList();
  }
  Future<List<Aya>> getAyasJuz(String where) async {
    var dbClient = await db;
    // specify the column names you want in the result set
    var listAyaMap = await dbClient.query(
      'quran_id',
      columns:  ['*'],
      where: where,
    );
    var listAya = listAyaMap.map((v) {
      var aya = Aya.fromJson(v);
      return aya;
    });
    return listAya.toList();
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
  Future<JuzModel> getJuzs() async {
    if (_juzModel == null) {
      var json = await loadString('assets/quran-data/juz.json');
      _juzModel = JuzModel.juzModelFromJson(json);
      for (var juz in _juzModel.juzs) {
        int firstSura = int.parse(juz.verseMapping.keys.first);
        int firstAya = int.parse(juz.verseMapping.values.first.split("-")[0]);
        var a = await getQuranListAya2(
          firstSura,
          firstAya,
        );
        juz.aya = a.first?.text;
      }
    }
    return _juzModel;
  }

  Future<List<Aya>> getQuranListAya2(
    int firstSura,
    int firstAya,
  ) async {
    List<Aya> listAya = await getQuranListAya(
      firstSura
    );
    listAya = listAya
        .where(
          (v) => v.aya == firstAya.toString(),
        )
        .toList();
    return listAya;
  }

  Future<List<Aya>> getQuranListAya(int sura) async {
    var listAya = await getAyas(sura);

    List<BookmarksModel> bookmarks = [];

      bookmarks = await BookmarksDataService().getListBookmarks();
    
    listAya.forEach(
      (aya) {
          var bookmark = bookmarks?.firstWhere(
            (b) => b.sura == sura && b.aya?.toString() == aya.aya,
            orElse: () => null,
          );
          aya.bookmarksModel = bookmark;
          aya.isBookmarked = bookmark != null;
        
        return aya;
      },
    );
    return listAya.toList();
  }

  Future<List<Aya>> getQuranListAyaJuz(String where,int sura) async {
    var listAya = await getAyasJuz(where);

    List<BookmarksModel> bookmarks = [];

      bookmarks = await BookmarksDataService().getListBookmarks();
    
    listAya.forEach(
      (aya) {
          var bookmark = bookmarks?.firstWhere(
            (b) => b.sura == sura && b.aya?.toString() == aya.aya,
            orElse: () => null,
          );
          aya.bookmarksModel = bookmark;
          aya.isBookmarked = bookmark != null;
        
        return aya;
      },
    );
    return listAya.toList();
  }

  Future<Map<TranslationDataKey, List<TranslationAya>>> getTranslations(
      Chapter chapter) async {
    Map<TranslationDataKey, List<TranslationAya>> mapTranslation = {};
    var listTranslationDataKey =
        await TranslationsListService().getListTranslationsDataIsVisibleOnly();

    // Create database connection from translation data key
    Map<TranslationDataKey, Database> translations = {};
    try {
      for (var translationDataKey in listTranslationDataKey) {
        Database database = await initDb(
          '${translationDataKey.id}.db',
          translationDataKey.url,
        );
        translations.addAll(
          {
            translationDataKey: database,
          },
        );
      }
      for (var t in translations.entries) {
        var ayaTranslation = await t.value.query(
          'verses',
          columns: ['*'],
          where: 'sura = ${chapter.chapterNumber}',
        );
        mapTranslation.addAll(
          {
            t.key: ayaTranslation.map(
              (v) {
                // Check this fromJson
                return TranslationAya.fromJson(v);
              },
            ).toList(),
          },
        );
      }
    } finally {
      // Dispose database connection
      translations.entries.forEach((v) {
        v.value.close();
      });
      translations.clear();
    }
    return mapTranslation;
  }

  Future<Map<TranslationDataKey, List<TranslationAya>>> getTranslationsJuz(
      String where) async {
    Map<TranslationDataKey, List<TranslationAya>> mapTranslation = {};
    var listTranslationDataKey =
        await TranslationsListService().getListTranslationsDataIsVisibleOnly();

    // Create database connection from translation data key
    Map<TranslationDataKey, Database> translations = {};
    try {
      for (var translationDataKey in listTranslationDataKey) {
        Database database = await initDb(
          '${translationDataKey.id}.db',
          translationDataKey.url,
        );
        translations.addAll(
          {
            translationDataKey: database,
          },
        );
      }
      for (var t in translations.entries) {
        var ayaTranslation = await t.value.query(
          'verses',
          columns: ['*'],
          where: where,
        );
        mapTranslation.addAll(
          {
            t.key: ayaTranslation.map(
              (v) {
                // Check this fromJson
                return TranslationAya.fromJson(v);
              },
            ).toList(),
          },
        );
      }
    } finally {
      // Dispose database connection
      translations.entries.forEach((v) {
        v.value.close();
      });
      translations.clear();
    }
    return mapTranslation;
  }
  
}
