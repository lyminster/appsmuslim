
import 'dart:math';
import 'dart:typed_data';

import 'package:appsmuslim/helpers/globalVar.dart';
import 'package:appsmuslim/helpers/waktuSolat_helpers.dart';
import 'package:appsmuslim/pages/quran/provider/locationProvider.dart';
import 'package:appsmuslim/pages/waktu/model/waktuModel.dart';
import 'package:appsmuslim/pages/waktu/provider/prayer_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hijri/umm_alqura_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WaktuProvider extends ChangeNotifier {
  bool isGettingData = true;
  bool isGettingDataBulanan = true;
  String url = GlobalVar().PTAMIurlAPI;
  String tanggalHijria = "";
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final f = new DateFormat('yyyy-MM-dd');
  
  WaktuProvider(){
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  int menit = 0;
  String namaSolat = '';
  List<DetailWaktu> prayerTimes = [];
  List<WaktuBulan> databulanan = [];
  final List<String> litems = [
    'Imsak',
    'Subuh',
    'Dhuha',
    'Dzuhur',
    'Ashar',
    'Maghrib',
    'Isya'
  ];
  List<WaktuNotification> liststatuswaktusolat = [];

  gettanggalhijriah(tanggal) async {
    var hdate = ummAlquraCalendar.fromDate(tanggal);
    String tanggalh = hdate.hDay.toString() + " " + hdate.longMonthName.toString() + " " + hdate.hYear.toString() ;
    tanggalHijria = tanggalh;
    //tanggal DD-MM-YYYY
    // var apiurl = 'http://api.aladhan.com/v1/gToH?date=$tanggal';

    // final response = await http.get(apiurl);
    // var hasil = json.decode(response.body);
    // tanggalHijria = hasil["data"]["hijri"]["date"];
  }

//getdata status waktu
  getstatusnotif(tanggal) async {
    liststatuswaktusolat = [];
    liststatuswaktusolat = await WaktuSolatDataService().getlistNotif();
    var pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
        // print(pendingNotificationRequests);
    await flutterLocalNotificationsPlugin.cancelAll();
    prayerTimes.forEach((data) {
      liststatuswaktusolat.forEach((data2) {
        if (data.nama == data2.namaSolat) {
          data.notificationStatus = true;
          if(data.solatStatus == true){
            _showNotificationWithDefaultSound(data2.namaSolat,data.jam,tanggal);
          }
        }
      });
    });
  }

  Future _showNotificationWithDefaultSound(String judul, seconds , tanggal) async {
    // var scheduledNotificationDateTime =
    //     DateTime.now().add(Duration(seconds: seconds));
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    var scheduledNotificationDateTime = DateTime.parse("${f.format(tanggal)} ${seconds}:00");
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        sound: RawResourceAndroidNotificationSound('adzan'),
        importance: Importance.Max,
        vibrationPattern: vibrationPattern,
        priority: Priority.High);
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(sound: "adzan.aiff");
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
      0,
      judul,
      'Solat $judul telah tiba',
      scheduledNotificationDateTime,
      platformChannelSpecifics
    );
  }

  updateStatus(value) {
    prayerTimes.forEach((data) {
      if (data.nama == value) {
        data.notificationStatus = !data.notificationStatus;
      }
    });
    notifyListeners();
  }

  deleteStatus(String data) async {
    await WaktuSolatDataService().delete(data);
  }

  addStatus(WaktuNotification data) async {
    // WaktuSolatDataService().add(WaktuNotification(namaSolat:'Subuh'));
    await WaktuSolatDataService().add(data);
  }

  setWaktuBulan(data) {
    databulanan = data;
    isGettingDataBulanan = false;
    //notifyListeners();
  }

  setDataWaktu(data,tanggal) {
    List<String> litemswaktu = [];
    litemswaktu.add(getimsak(data[0]));
    litemswaktu.add(data[0]);
    litemswaktu.add(data[1]);
    litemswaktu.add(data[2]);
    litemswaktu.add(data[3]);
    litemswaktu.add(data[4]);
    litemswaktu.add(data[6]);
    var dataStatus = cekJamterdekat(litemswaktu,tanggal);
    var jamharianHabis = dataStatus.contains(true);
    
    if(jamharianHabis){
      prayerTimes = [];
      prayerTimes
          .add(new DetailWaktu("Imsak", getimsak(data[0]), dataStatus[0], false));
      prayerTimes.add(new DetailWaktu("Subuh", data[0], dataStatus[1], false));
      prayerTimes.add(new DetailWaktu("Dhuha", data[1], dataStatus[2], false));
      prayerTimes.add(new DetailWaktu("Dzuhur", data[2], dataStatus[3], false));
      prayerTimes.add(new DetailWaktu("Ashar", data[3], dataStatus[4], false));
      prayerTimes.add(new DetailWaktu("Maghrib", data[4], dataStatus[5], false));
      prayerTimes.add(new DetailWaktu("Isya", data[6], dataStatus[6], false));
    }
    
    
    return jamharianHabis;
  }

  setloading(value) {
    isGettingData = value;
    notifyListeners();
  }

  getDataBulan(DateTime tanggal , positionlat,positionlong) {
    var bulan = tanggal.month;
    var now = new DateTime(tanggal.year, tanggal.month, 1);
    List<WaktuBulan> localdata = [];
    isGettingDataBulanan = true;

    do {
      PrayerTime prayers = new PrayerTime();
      prayers.setTimeFormat(prayers.getTime24());
      prayers.setCalcMethod(prayers.getKarachi());
      prayers.setAsrJuristic(prayers.getShafii());
      prayers.setAdjustHighLats(prayers.getAdjustHighLats());

      List<int> offsets = [
        0,
        0,
        0,
        0,
        0,
        0,
        0
      ]; // {Fajr,Sunrise,Dhuhr,Asr,Sunset,Maghrib,Isha}
      prayers.tune(offsets);
      var hasil = prayers.getPrayerTimes(now, positionlat, positionlong, 7.0);
      // var hasil = prayers.getPrayerTimes(now, -6.173110, 106.829361, 7.0);
      localdata.add(new WaktuBulan(
        now.day.toString(),
        getimsak(hasil[0]),
        hasil[0],
        hasil[1],
        hasil[2],
        hasil[3],
        hasil[4],
        hasil[6],
      ));

      now = now.add(new Duration(days: 1));
    } while (now.month == bulan);

    setWaktuBulan(localdata);
  }

  getData(now, positionlat,positionlong) {
    PrayerTime prayers = new PrayerTime();
    prayers.setTimeFormat(prayers.getTime24());
    prayers.setCalcMethod(prayers.getKarachi());
    prayers.setAsrJuristic(prayers.getShafii());
    prayers.setAdjustHighLats(prayers.getAdjustHighLats());

    List<int> offsets = [
      0,
      0,
      0,
      0,
      0,
      0,
      0
    ]; // {Fajr,Sunrise,Dhuhr,Asr,Sunset,Maghrib,Isha}
    prayers.tune(offsets);
    var hasil = prayers.getPrayerTimes(now, positionlat, positionlong, 7.0);
    // var hasil = prayers.getPrayerTimes(now, -6.173110, 106.829361, 7.0);
    var value = setDataWaktu(hasil,now);

    if(value){
      getstatusnotif(now);
      setloading(false);
    }
    else{
      var hasil = prayers.getPrayerTimes(now.add(new Duration(days: 1)), positionlat, positionlong, 7.0);
      // var hasil = prayers.getPrayerTimes(now.add(new Duration(days: 1)), -6.173110, 106.829361, 7.0);
      var value = setDataWaktu(hasil,now.add(new Duration(days: 1)));
      getstatusnotif(now.add(new Duration(days: 1)));
      setloading(false);
    }
    
  }

  getSeconds(data) {
    var hasil = [];
    for (var i = 0; i < data.length; i++) {
      String s = data[i];
      TimeOfDay _startTime = TimeOfDay(
          hour: int.parse(s.split(":")[0]), minute: int.parse(s.split(":")[1]));
      final now1 = new DateTime.now();
      final now2 = new DateTime(
          now1.year, now1.month, now1.day, _startTime.hour, _startTime.minute);
      final difference = now2.difference(now1).inSeconds;
      hasil.add(difference);
    }
    var closeToZero = getclosehasil(hasil);
    menit = closeToZero;
  }

  getNextSolat() {
    for (int i = 0; i < prayerTimes.length; i++) {
      if (prayerTimes[i].solatStatus == true) {
        namaSolat = prayerTimes[i].nama;
      }
    }
  }

  getimsak(data) {
    var jam = int.parse(data.split(":")[0]);
    var menit = int.parse(data.split(":")[1]);

    var jamKeMenit = jam * 60;
    var totalMenit = jamKeMenit + menit;
    var imsak = totalMenit - 10;

    //kembali ke jam
    int jamim = imsak % 3600 ~/ 60;
    int menitim = imsak % 60;

    return formatTime(jamim) + ":" + formatTime(menitim);
  }

  String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }

  cekJamterdekat(data,tanggal) {
    var hasil = [];
    for (var i = 0; i < data.length; i++) {
      String s = data[i];
      TimeOfDay _startTime = TimeOfDay(
          hour: int.parse(s.split(":")[0]), minute: int.parse(s.split(":")[1]));
      final now1 = new DateTime.now();
      final now2 = new DateTime(
          tanggal.year, tanggal.month, tanggal.day, _startTime.hour, _startTime.minute);
      final difference = now2.difference(now1).inSeconds;
      hasil.add(difference);
    }
    var closeToZero = getclosehasil(hasil);
    menit = closeToZero;
    var dataSolatStatus = [];
    if (closeToZero > 0) {
      for (var i = 0; i < hasil.length; i++) {
        if (hasil[i] == closeToZero) {
          dataSolatStatus.add(true);
        } else {
          dataSolatStatus.add(false);
        }
      }
    } else {
      dataSolatStatus = [false, false, false, false, false,false, false];
    }
    return dataSolatStatus;
  }

  // getclose(hasil){
  //   if(0 < hasil[0]) {
  //           return hasil[0];
  //       }
  //       if(0 > hasil[hasil.length-1]) {
  //           return hasil[hasil.length-1];
  //       }

  //       int lo = 0;
  //       int hi = hasil.length - 1;

  //       while (lo <= hi) {
  //           int mid = ((hi + lo) / 2).round();

  //           if (0 < hasil[mid]) {
  //               hi = mid - 1;
  //           } else if (0 > hasil[mid]) {
  //               lo = mid + 1;
  //           } else {
  //               return hasil[mid];
  //           }
  //       }
  //       // lo == hi + 1
  //       return (hasil[lo] - 0) < (0 - hasil[hi]) ? hasil[lo] : hasil[hi];
  // }
  getclosehasil(hasil) {
    List<int> arraypos = [];
    for (var i = 0; i < hasil.length; i++) {
      if (hasil[i] > 0) {
        arraypos.add(hasil[i]);
      }
    }
    return arraypos.length < 1 ? 0 : arraypos.reduce(min);
  }
}
