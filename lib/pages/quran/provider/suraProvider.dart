import 'package:appsmuslim/database/dbHelper.dart';
import 'package:appsmuslim/pages/quran/models/suraModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ListSuraData extends ChangeNotifier {
  bool isGettingChapters = true;
  ChaptersModel chaptersModel = ChaptersModel();

  // ListSuraData(){
    
  // }

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

  getcurrentchapter(suraNo){
    for(int i = 0 ; i < chaptersModel.chapters.length ; i++){
      if(chaptersModel.chapters[i].chapterNumber.toString() == suraNo){
        return chaptersModel.chapters[i];
      }
    }
  }

  getname(String name){
    for (int i = 0 ; i < chaptersModel.chapters.length ; i++){
      if(chaptersModel.chapters[i].chapterNumber == int.parse(name)){
        return chaptersModel.chapters[i].nameSimple;
      }
    }
  }
}
