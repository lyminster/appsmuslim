import 'package:appsmuslim/database/dbHelper.dart';
import 'package:appsmuslim/pages/quran/models/suraModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ListSuraData extends ChangeNotifier {
  bool isGettingChapters = true;
  ChaptersModel chaptersModel = ChaptersModel();

  ListSuraData(){
    
  }

  Future getChapters() async {
    try {
      isGettingChapters = true;

      chaptersModel = await DBHelper().getChapters();
      notifyListeners();
    } finally {
      isGettingChapters = false;
      notifyListeners();
    }
  }
}
