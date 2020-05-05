import 'dart:async';

import 'package:appsmuslim/pages/hadist/homeHadist.dart';
import 'package:appsmuslim/pages/hadist/mainHadist.dart';
import 'package:appsmuslim/pages/ikra/mainIkra.dart';
import 'package:appsmuslim/pages/komik/listKomik.dart';
import 'package:appsmuslim/pages/komik/mainKomik.dart';
import 'package:appsmuslim/pages/login/loginPage.dart';
import 'package:appsmuslim/pages/login/profilePage.dart';
import 'package:appsmuslim/pages/login/test.dart';
import 'package:appsmuslim/pages/quran/provider/locationProvider.dart';
import 'package:appsmuslim/pages/quran/qibla_new.dart';
import 'package:appsmuslim/pages/waktu/provider/waktuProvider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:appsmuslim/pages/quran/mainMenuQuran.dart';
import 'package:appsmuslim/pages/quran/mainQuran.dart';
import 'package:appsmuslim/pages/quran/qibla.dart';
import 'package:appsmuslim/pages/waktu/waktu.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int bottomSelectedIndex = 0;

  var now = new DateTime.now();
  var formatter = new DateFormat('dd MMMM yyyy');
  Position position;
  List<Placemark> placemark;
  Timer _timer;
  int seconds;
  var datasolat;
  String namaSolat;
  String jamSolat;
  bool notifikasiSolat;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();

    getinitaldata();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
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

  getinitaldata() async {
    await getpos();
    await dataHeader();
  }

  getpos() async {
    //GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    // placemark =
    //     await Geolocator().placemarkFromCoordinates(-6.173110, 106.829361);
    getPrayerTimes();
  }

  dataHeader() async {
    await Provider.of<LocationData>(context,listen: false).getdata();
    await Provider.of<WaktuProvider>(context, listen: false).getNextSolat();
    seconds = Provider.of<WaktuProvider>(context, listen: false).menit;
    datasolat = Provider.of<WaktuProvider>(context, listen: false).prayerTimes;
    datasolat.forEach((elem) => {
          if (elem.solatStatus)
            {
              namaSolat = elem.nama,
              jamSolat = elem.jam,
              notifikasiSolat = elem.notificationStatus
            }
        });
    startTimer();
  }

  getPrayerTimes() async {
    // await Provider.of<WaktuProvider>(context, listen: false)
    //     .getData(now, position);
  }

  Future _showNotificationWithDefaultSound(String judul) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        sound: RawResourceAndroidNotificationSound('slow_spring_board'),
        importance: Importance.Max,
        priority: Priority.High);
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      judul,
      'Solat $judul telah tiba',
      platformChannelSpecifics,
      payload: judul,
    );
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
        if (notifikasiSolat) {
          _showNotificationWithDefaultSound(namaSolat);
        }
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

  @override
  void dispose() {
    super.dispose();
    cancelTimer();
    position = null;
    placemark = null;
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      switch (index.toString()) {
        case '1':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainQuran()),
          );
          break;
        case '2':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WaktuSolat()),
          );
          break;
        case '3':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
          break;
        case '4':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F0F0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                  ),
                  color: Color(0xffC11018),
                ),
                width: MediaQuery.of(context).size.width,
                height: 75,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(17.0, 30.0, 0.0, 0.0),
                  child: Text(
                    'Indonesia, ${formatter.format(now)}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 20,
                          color: Color(0xffC11018),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                            ),
                            color: Color(0xffF0F0F0),
                          ),
                          height: 20,
                        ),
                        Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(12.0, 45.0, 0.0, 0.0),
                            child: Text(
                              'Assalamulaikum User',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                      ),
                      color: Color(0xffC11018),
                    ),
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      children: <Widget>[
                        seconds == null
                            ? Text("Loading...")
                            : Text(
                                constructTime(seconds),
                                style: TextStyle(
                                    fontSize: 17.0, color: Colors.white),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              width: 10.0,
                            ),
                            // Image(
                            //   image: AssetImage("assets/images/panahkiri.png"),
                            // ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WaktuSolat()),
                                );
                              },
                              child: jamSolat == null
                                  ? Text('00:00')
                                  : Text(
                                      jamSolat,
                                      style: TextStyle(
                                          fontSize: 46.0,
                                          color: Color(0xffF0F0F0),
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                            Image(
                              image: AssetImage("assets/images/panahkanan2.png"),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            namaSolat == null
                                ? Text('load..')
                                : Text(
                                    namaSolat,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                            SizedBox(
                              width: 30.0,
                            )
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 8.0, 0.0, 10.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MenuQibla()),
                              );
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.compass,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Arah Kiblat',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Stack(
                children: <Widget>[
                  Container(
                    height: 20,
                    color: Color(0xffC11018),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                      ),
                      color: Color(0xffF0F0F0),
                    ),
                    height: 20,
                  ),
                ],
              ),
              MainMenuQuran(),
              // MainIkra(),
              // MainParenting(),
              // MainKomik(),
              // MainHadist(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffF0F0F0),
        selectedItemColor: Color(0xffC11018),
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.quran),
            title: Text("Qur\'an"),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(FontAwesomeIcons.compass),
          //   title: Text("Hadist"),
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(FontAwesomeIcons.solidComment),
          //   title: Text("Komik"),
          // ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.clock),
            title: Text("Prayer"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Account"),
          ),
        ],
      ),
    );
  }
}
