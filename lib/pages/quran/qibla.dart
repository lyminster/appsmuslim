import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';

class Qibla extends StatefulWidget {
  @override
  _QiblaState createState() => _QiblaState();
}

class _QiblaState extends State<Qibla> {
  double _direction;
  double _directionKiblat = 0;  
  Position position ;
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
    placemark =
        await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    
    await getdirect(
        position.latitude, position.longitude, 21.422510, 39.826168);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Arah Qibla',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                // Image.asset(
                //   'assets/images/arrow.jpg',
                //   height: 200.0,
                //   width: 200.0,
                // ),
                Transform.rotate(
                  angle: ((_direction ?? 0) * (math.pi / 180) * -1),
                  child: Image.asset(
                    'assets/images/arrow.jpg',
                    width: 200,
                    height: 200,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Divider(
                  thickness: 2.0,
                  color: Colors.green,
                ),
                Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          'Kota',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        )),
                        placemark == null ? Text('Loading...') : Text('${placemark[0].name}'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          'Longitute',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        )),
                        position == null ? Text('Loading...') : Text(position.longitude.toString()),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          'Latitute',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        )),
                        position == null ? Text('Loading...') : Text(position.latitude.toString()),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
