import 'package:appsmuslim/pages/quran/models/ayaModel.dart';
import 'package:appsmuslim/pages/quran/models/juzModel.dart';
import 'package:appsmuslim/pages/quran/models/suraModel.dart';
import 'package:appsmuslim/pages/quran/models/transModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:appsmuslim/database/dbHelper.dart';
import 'package:sqflite/sqflite.dart';

class ListAyaData extends ChangeNotifier {

  bool isGettingAya = true;

  List<Aya> listAya = [];

  Map<TranslationDataKey, List<TranslationAya>> translations = {};

  List<TranslationAya> listTrans = [];

  Map<Chapter, List<Aya>> chapters = {};

  Chapter currentChapter;
  
  Juz currentJuz;
  
  ScrollController controller1 = ScrollController();
  


  bool trans = true;
  tutuptrans() {
      trans = !trans;
      notifyListeners();
  }

  setGeting(value){
    isGettingAya = value;
    notifyListeners();
  }

  
  jalanScroll(index){
    var totallength = index * 100;
    controller1.animateTo(double.parse(totallength) , duration: Duration(seconds: 10), curve: Curves.easeOut);
  }

  Future getAya(Chapter chapter) async {
    try {
      isGettingAya =true;

      currentChapter = chapter;
      listAya = await DBHelper().getQuranListAya(chapter.chapterNumber);
      // translations = await DBHelper().getTranslations(chapter);

      notifyListeners();
    } finally {
      setGeting(false);
    }
  }
  Future getAyaJuz(juz,List<String> where,List<int> suras) async {
    try {
      isGettingAya =true;

      currentJuz = juz;
      
      for(int i = 0 ; i < where.length ; i++) {
        var hasil  = await DBHelper().getQuranListAyaJuz(where[i],suras[i]);
        // var hatranslations = await DBHelper().getTranslationsJuz(where[i].replaceAll('aya', 'ayah'));
        // hatranslations.forEach((k,v){ listTrans = listTrans + v;});
        // for (var t in hatranslations.entries) {
        //     translations = {};
        //     translations.addAll({
        //       t.key: listTrans
        //     });
        // };
        listAya = listAya + hasil;
      }
      
      

      
    } finally {
      setGeting(false);
    }
  }
  kosongkandata(){
    listAya = [];
    listTrans = [];
    translations = {};
  }
  setnotify(){
      setGeting(false);
  }

}
