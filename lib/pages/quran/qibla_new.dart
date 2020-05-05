import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';

class MenuQibla extends StatefulWidget {
  @override
  _MenuQiblaState createState() => _MenuQiblaState();
}

class _MenuQiblaState extends State<MenuQibla> {
  double _direction;
  double _directionKiblat = 0;
  Position position;
  List<Placemark> placemark;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    FlutterCompass.events.listen((double direction) {
      setState(() {
        _direction = direction + _directionKiblat;
      });
    });
  }
  @override
  void dispose(){
    super.dispose();
  }

  getdirect(lat1, lng1, lat2, lng2) {
    var dLon = (lng2 - lng1);
    var y = math.sin(dLon) * math.cos(lat2);
    var x = math.cos(lat1) * math.sin(lat2) -
        math.sin(lat1) * math.cos(lat2) * math.cos(dLon);
    var brng = math.atan2(y, x);
    var hasil = brng * (180 / math.pi) * -1;
    //var derajat = (brng > 0 ? brng : (2*math.pi + brng)) * 360 / (2*math.pi);

    setState(() {
      _directionKiblat = hasil;
    });
  }

  _getCurrentLocation() async {
    position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);

    await getdirect(
        position.latitude, position.longitude, 21.422510, 39.826168);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Arah Kiblat', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Color(0xffB80707),
      ),
      backgroundColor: Color(0xffF1F1F1),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: placemark == null
                      ? Text('Loading...')
                      : Text(
                          '${placemark[0].subAdministrativeArea} , ${placemark[0].subLocality}',
                        ),
                ),
              ],
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Transform.rotate(
                      angle: ((_direction ?? 0) * (math.pi / 180) * -1),
                      child: Image.asset('assets/images/jarum.png'),
                    ),
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xffE4131D),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: _directionKiblat != 0
                            ? Text(
                                _directionKiblat.toStringAsFixed(0),
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              )
                            : Text('load...'),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(58.0),
              child: Text(
                'Bila ingin lebih akurat, harap handphone di gerakan seperti angka 8',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
