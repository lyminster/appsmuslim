import 'dart:async';
import 'dart:typed_data';

import 'package:appsmuslim/pages/bulanSolat.dart';
import 'package:appsmuslim/pages/quran/qibla_new.dart';
import 'package:appsmuslim/pages/waktu/model/waktuModel.dart';
import 'package:appsmuslim/pages/waktu/provider/waktuProvider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class WaktuSolat extends StatefulWidget {
  @override
  _WaktuSolatState createState() => _WaktuSolatState();
}

class _WaktuSolatState extends State<WaktuSolat> {
  List<String> litemswaktu = [];
  var now = new DateTime.now();
  var formatter = new DateFormat.yMMMMd('en_US');
  Position position;
  var isGpsEnabled;
  List<Placemark> placemark;
  Timer _timer;
  int seconds;
  String namaSolat;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();

    getinitaldata();
    // var initializationSettingsAndroid =
    //     new AndroidInitializationSettings('app_icon');
    // var initializationSettingsIOS = IOSInitializationSettings();
    // var initializationSettings = InitializationSettings(
    //     initializationSettingsAndroid, initializationSettingsIOS);
    // flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    // flutterLocalNotificationsPlugin.initialize(initializationSettings);

  }
  Future _showNotificationWithDefaultSound(String judul) async {
    // var scheduledNotificationDateTime =
    //     DateTime.now().add(Duration(seconds: seconds));
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    // var scheduledNotificationDateTime = DateTime.parse("${f.format(tanggal)} ${seconds}:00");
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
    await flutterLocalNotificationsPlugin.show(
      0,
      judul,
      'Solat $judul telah tiba',
      // scheduledNotificationDateTime,
      platformChannelSpecifics,
      payload: "ini testing"
    );
  }

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: const Text("Here is your payload"),
        content: new Text("Payload :$payload"),
      ),
    );
  }

  // Method 2
  

  getinitaldata() async {
    await getpos();
    await dataHeader();
  }

  getpos() async {
    isGpsEnabled = await Geolocator().isLocationServiceEnabled();
    // print(isGpsEnabled);

    if(isGpsEnabled){
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      placemark = await Geolocator()
          .placemarkFromCoordinates(position.latitude, position.longitude);
      await Provider.of<WaktuProvider>(context, listen: false)
        .getData(now, position.latitude,position.longitude);
    }else{
      // placemark =
      //     await Geolocator().placemarkFromCoordinates(-6.173110, 106.829361);
      await Provider.of<WaktuProvider>(context, listen: false)
        .getData(now, -6.173110, 106.829361);
    }
  }

  addDate() {
    now = now.add(new Duration(days: 1));
    Provider.of<WaktuProvider>(context, listen: false).gettanggalhijriah(now);
    getPrayerTimes();
  }

  substractDate() {
    now = now.add(new Duration(days: -1));
    Provider.of<WaktuProvider>(context, listen: false).gettanggalhijriah(now);
    getPrayerTimes();
  }

  getPrayerTimes() async {

  }

  dataHeader() async {
    await Provider.of<WaktuProvider>(context, listen: false).getNextSolat();
    await Provider.of<WaktuProvider>(context, listen: false)
        .gettanggalhijriah(now);
    seconds = Provider.of<WaktuProvider>(context, listen: false).menit;
    startTimer();
  }

  String constructTime(int seconds) {
    int hour = seconds ~/ 3600;
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;
    return formatTime(hour) + " jam " + formatTime(minute) + " menit lagi";
    //  +
    // formatTime(second);
  }

  String formatTime(int timeNum) {
    return timeNum < 1 ? "0" : timeNum.toString();
  }

  void startTimer() {
    // Set 1 second callback
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      // Update interface
      setState(() {
        // minus one second because it calls back once a second
        seconds--;
      });
      if (seconds == 0) {
        //panggil notifikasi
        // _showNotificationWithDefaultSound("Ashar");
        // Countdown seconds 0, cancel timer
        cancelTimer();
        //get new timmer for next jadwal solat
        getinitaldata();
      }
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    cancelTimer();
    position = null;
    placemark = null;
  }

  @override
  Widget build(BuildContext context) {
    final WaktuProvider waktuData = Provider.of<WaktuProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Color(0xffC11018),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.compass,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuQibla()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Color(0xffC11018),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 36.0, 0.0, 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: placemark != null
                          ? Text(
                              '${placemark[0].subAdministrativeArea} , ${placemark[0].subLocality}',
                              style: TextStyle(
                                fontSize: 12.0,
                                letterSpacing: 1.2,
                                color: Colors.white
                              ),
                            )
                          : Text('Jakarta Indonesia'),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                      child: Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        color: Colors.white,
                        size: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.clock,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  seconds == null
                      ? Text("Loading...")
                      : Text(
                          constructTime(seconds),
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            color: Colors.white
                          ),
                        ),
                ],
              ),
              SizedBox(
                height: 105,
              ),
              Container(
                color: Color(0xffCBCBCB),
                height: 66,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24.0, 0.0, 0.0, 0.0),
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                substractDate();
                              },
                              child: Icon(
                                FontAwesomeIcons.chevronLeft,
                                size: 25.0,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '${formatter.format(now)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    Text(
                                      '${waktuData.tanggalHijria}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                addDate();
                              },
                              child: Icon(
                                FontAwesomeIcons.chevronRight,
                                size: 25.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 28, 0),
                      child: InkWell(
                        onTap: () {
                          // _showNotificationWithDefaultSound("Ashar");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BulanSolat()),
                          );
                        },
                        child: Text(
                          'Lihat semua',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Divider(
              //     thickness: 2.0,
              //     color: Colors.black,
              //   ),
              // ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: waktuData.prayerTimes.length,
                itemBuilder: (context, index) {
                  return waktuData.isGettingData
                      ? Container()
                      : Container(
                          decoration: BoxDecoration(
                            // border: Border.all(
                            //   color: Color(0xffD2BB9A),
                            //   width:
                            //       1, //                   <--- border width here
                            // ),
                            color: index % 2 == 0
                                ? Color(0xffF0F0F0)
                                : Color(0xffFFFFFF),
                          ),
                          height: waktuData.prayerTimes[index].solatStatus
                              ? 84
                              : 47,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 50,
                              ),
                              Expanded(
                                child: Text(
                                  waktuData.prayerTimes[index].nama,
                                  style: TextStyle(
                                    color:
                                        waktuData.prayerTimes[index].solatStatus
                                            ? Color(0xffC11018)
                                            : Color(0xff271705),
                                    fontSize:
                                        waktuData.prayerTimes[index].solatStatus
                                            ? 24
                                            : 14.0,
                                    fontWeight:
                                        waktuData.prayerTimes[index].solatStatus
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                              Text(
                                waktuData.prayerTimes[index].jam,
                                style: TextStyle(
                                  color:
                                      waktuData.prayerTimes[index].solatStatus
                                          ? Color(0xffC11018)
                                          : Color(0xff271705),
                                  fontSize:
                                      waktuData.prayerTimes[index].solatStatus
                                          ? 24
                                          : 14.0,
                                  fontWeight:
                                      waktuData.prayerTimes[index].solatStatus
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              SizedBox(
                                width: 92,
                              ),
                              InkWell(
                                onTap: () async {
                                  if (!waktuData
                                      .prayerTimes[index].notificationStatus) {
                                    await Provider.of<WaktuProvider>(context,
                                            listen: false)
                                        .addStatus(WaktuNotification(
                                            namaSolat: waktuData
                                                .prayerTimes[index].nama));
                                  } else {
                                    await Provider.of<WaktuProvider>(context,
                                            listen: false)
                                        .deleteStatus(
                                            waktuData.prayerTimes[index].nama);
                                  }
                                  await Provider.of<WaktuProvider>(context,
                                          listen: false)
                                      .updateStatus(
                                          waktuData.prayerTimes[index].nama);
                                },
                                child: Icon(
                                  waktuData
                                          .prayerTimes[index].notificationStatus
                                      ? FontAwesomeIcons.volumeUp
                                      : FontAwesomeIcons.volumeMute,
                                  size: 25,
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              )
                            ],
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
