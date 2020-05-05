import 'dart:async';

import 'package:appsmuslim/pages/komik/mainKomik.dart';
import 'package:appsmuslim/pages/login/loginPage.dart';
import 'package:appsmuslim/pages/quran/provider/locationProvider.dart';
import 'package:appsmuslim/pages/quran/qibla_new.dart';
import 'package:appsmuslim/pages/waktu/provider/waktuProvider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:appsmuslim/pages/quran/mainMenuQuran.dart';
import 'package:appsmuslim/pages/quran/mainQuran.dart';
import 'package:appsmuslim/pages/waktu/waktu.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'homeinspirasi.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int bottomSelectedIndex = 0;
  var isGpsEnabled;
  var now = new DateTime.now();
  var formatter = new DateFormat('E, dd/MMM/yyyy');
  Position position;
  List<Placemark> placemark;
  Timer _timer;
  int seconds;
  var datasolat;
  String namaSolat;
  String jamSolat;
  bool notifikasiSolat;

  @override
  void initState() {
    super.initState();

    getinitaldata();
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
      //     await Geolocator().placemarkFromCoordinates(52.2165157, 6.9437819);
      await Provider.of<WaktuProvider>(context, listen: false)
        .getData(now, -6.173110, 106.829361);
    }
  }

  dataHeader() async {
    await Provider.of<LocationData>(context, listen: false).getdata();
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
      if (seconds <= 0) {
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
    // setState(() {
    //   bottomSelectedIndex = index;
    // });
  }

  void bottomTapped(int index) {
    setState(() {
      // bottomSelectedIndex = index;
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
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  32.0,
                  0,
                  0,
                  0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                      ),
                      color: Color(0xffC11018),
                      image: DecorationImage(
                        colorFilter: new ColorFilter.mode(
                            Colors.grey.withOpacity(0.025), BlendMode.modulate),
                        image: AssetImage('assets/images/patern.png'),
                        fit: BoxFit.fill,
                      )),
                  height: 200,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 18.0, 18.0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Image.asset('assets/images/iconlocation.png'),
                            SizedBox(
                              width: 10,
                            ),
                            placemark == null
                                ? Text(
                                    'Jakarta Indonesia',
                                    style: TextStyle(color: Colors.white),
                                  )
                                : Text(
                                    '${placemark[0].subAdministrativeArea} , ${placemark[0].subLocality}',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  )
                          ],
                        ),
                      ),
                      Expanded(
                          child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        0,
                                        10,
                                        0,
                                        0,
                                      ),
                                      child: seconds == null
                                          ? Text(
                                              "Loading...",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )
                                          : Text(
                                              constructTime(seconds),
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.white),
                                            ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WaktuSolat()));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          jamSolat == null
                                              ? Text(
                                                  '00:00',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              : Text(
                                                  jamSolat,
                                                  style: TextStyle(
                                                      fontSize: 55.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        namaSolat == null
                                            ? Text(
                                                'load..',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            : Text(
                                                namaSolat,
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/panahkanan.png',
                                    colorBlendMode: BlendMode.multiply,
                                  )
                                ],
                              )
                            ],
                          )),
                          Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MenuQibla()));
                              },
                              child: Container(
                                child: Center(
                                    child: Image.asset(
                                        'assets/images/iconKiblat.png')),
                              ),
                            ),
                          ),
                        ],
                      )),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(0.0, 0.0, 18.0, 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text('${formatter.format(now)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // Stack(
              //   children: <Widget>[
              //     Container(
              //       height: 20,
              //       color: Color(0xffC11018),
              //     ),
              //     Container(
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.only(
              //           topRight: Radius.circular(20.0),
              //         ),
              //         color: Color(0xffF0F0F0),
              //       ),
              //       height: 20,
              //     ),
              //   ],
              // ),
              Inpirasi(),
              MainMenuQuran(),
              // MainIkra(),
              // MainParenting(),
              MainKomik(),
              SizedBox(
                height: 50,
              )
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
            icon: Image.asset("assets/images/home.png"),
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
            icon: Icon(FontAwesomeIcons.solidClock),
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
