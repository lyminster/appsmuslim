import 'package:appsmuslim/helpers/globalVar.dart';
import 'package:appsmuslim/pages/komik/models/modelKomik.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class KomikProvider extends ChangeNotifier {
  bool isGettingData = true;
  List<Komik> dataKomik = [];
  String url = GlobalVar().PTAMIurlAPI;

  setDataKomikList(data) {
    dataKomik = data;
    
  }

  setloading(value) {
    isGettingData = value;
    notifyListeners();
  }

  getData() async {
    final response = await http.get('http://192.168.4.179:3031/komik');

    List res = json.decode(response.body);
    List<Komik> data = [];

    for (var i = 0; i < res.length; i++) {
      var post = Komik.fromJson(res[i]["data"]);
      data.add(post);
    }
    setDataKomikList(data);
  }

  setStatus(List<String> userKomik) {
    dataKomik.forEach((value) => {
          userKomik.forEach((value1) => {
                if (value.komikChapter == value1) {value.statusKomik = true}
              })
        });
        setloading(false);
  }
}
