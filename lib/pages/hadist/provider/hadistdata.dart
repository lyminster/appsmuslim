import 'package:appsmuslim/pages/hadist/model/hadistMenuModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;


class HadistDataProvider extends ChangeNotifier {

  List<ListKitabData> datakitab = [];
  List<ListBabData> databab = [];
  List<ListHadistData> datahadist = [];



  Future<String> loadString(String key) async {
    return await rootBundle.loadString(key);
  }

  getbyidkitab(int id){
    List<ListBabData> hasil = List<ListBabData>();
    for(int i = 0; i < databab.length ; i++){
      if(databab[i].idkitab == id){
        hasil.add(databab[i]);
      }
    }
    return hasil;
  }

  getbyidbab(int id){
    List<ListHadistData> hasil = List<ListHadistData>();
    for(int i = 0; i < datahadist.length ; i++){
      if(datahadist[i].idbab == id){
        hasil.add(datahadist[i]);
      }
    }
    return hasil;
  }

  getdata() async{
    
    datakitab = [];
    databab = [];
    datahadist = [];


    String jsonkitab = await loadString(
      'assets/quran-data/listkitab.json',
    );
    var hasil1 = json.decode(jsonkitab);
    for (var i = 0; i < hasil1.length; i++) {
      var post = ListKitabData.fromJson(hasil1[i]);
      datakitab.add(post);
    }


    String jsonbab = await loadString(
      'assets/quran-data/listbab.json',
    );
    var hasil2 = json.decode(jsonbab);
    for (var i = 0; i < hasil2.length; i++) {
      var post2 = ListBabData.fromJson(hasil2[i]);
      databab.add(post2);
    }

    String jsonhadist = await loadString(
      'assets/quran-data/listhadist.json',
    );
    var hasil3 = json.decode(jsonhadist);
    for (var i = 0; i < hasil3.length; i++) {
      var post3 = ListHadistData.fromJson(hasil3[i]);
      datahadist.add(post3);
    }

  }
}