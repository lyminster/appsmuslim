import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationData extends ChangeNotifier {
  
  Position position;
  List<Placemark> placemark;
  var isGpsEnabled;

  getdata() async {
    isGpsEnabled = await Geolocator().isLocationServiceEnabled();

    if(isGpsEnabled){
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      placemark = await Geolocator()
          .placemarkFromCoordinates(position.latitude, position.longitude);
    }
  }

}