import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SettingValues extends ChangeNotifier {

  double arabicText = 30;
  double transText = 20;

  updateArabicText(value){
    arabicText = value;
    notifyListeners();
  }
  updatetransText(value){
    transText = value;
    notifyListeners();
  }
}