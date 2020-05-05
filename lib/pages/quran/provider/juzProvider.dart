import 'package:appsmuslim/database/dbHelper.dart';
import 'package:appsmuslim/pages/quran/models/juzModel.dart';
import 'package:appsmuslim/pages/quran/models/suraModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ListJuzData extends ChangeNotifier {
  bool isGettingJuzs = true;
  ChaptersModel chaptersModel = ChaptersModel();
  JuzModel juzModel;
  

  Future getJuzs() async {
    try {
      isGettingJuzs = true;

      juzModel = await DBHelper().getJuzs();
      notifyListeners();
    } finally {
      isGettingJuzs = false;
      notifyListeners();
    }
  }

  Future getChapters() async {
    try {
      chaptersModel = await DBHelper().getChapters();
      notifyListeners();
    } finally {
      notifyListeners();
    }
  }
}
