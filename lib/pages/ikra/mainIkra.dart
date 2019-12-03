import 'package:appsmuslim/pages/quran/mainQuran.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainIkra extends StatefulWidget {
  @override
  _MainIkraState createState() => _MainIkraState();
}

class _MainIkraState extends State<MainIkra> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Ikra",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2),
          ),
          SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainQuran()),
              );
            },
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                  blurRadius: 11.0,
                )
              ]),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14.0),
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: 130.0,
                              width: 130.0,
                            ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Container(
                            height: 130.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "Baca Iqra",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                Text(
                                  "Baca dari Awal",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                Text(
                                  "Lanjut dari ayat",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.solidBookmark),
                          SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            child:
                                Text("Belum ada ayat Qur'an yang tersimpan..",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.2,
                                    )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
