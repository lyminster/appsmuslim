import 'package:appsmuslim/pages/hadist/homeHadist.dart';
import 'package:appsmuslim/pages/hadist/mainHadist.dart';
import 'package:appsmuslim/pages/ikra/mainIkra.dart';
import 'package:appsmuslim/pages/komik/listKomik.dart';
import 'package:appsmuslim/pages/komik/mainKomik.dart';
import 'package:appsmuslim/pages/quran/mainMenuQuran.dart';
import 'package:appsmuslim/pages/quran/mainQuran.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Testtt extends StatefulWidget {
  @override
  _TestttState createState() => _TestttState();
}

class _TestttState extends State<Testtt> {
  String haaa = "asdasdasd";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: MyClip(),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 280,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[400],
                                blurRadius: 11.0,
                              )
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xffE5E5E5),
                                Color(0xffE9C586),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          top: 28,
                          child: haaa == null ? Text(
                            'Jakarta , ',
                            style: TextStyle(fontSize: 12),
                          ) : Text('asdasdasd'),
                        ),
                        Positioned(
                          right: 40,
                          top: 60,
                          child: Text(
                            '1 jam 25 menit lagi',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Positioned(
                          right: 1,
                          top: 80,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  width: 10.0,
                                ),
                                Image(
                                  image:
                                      AssetImage("assets/images/panahkiri.png"),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "11:39",
                                    style: TextStyle(
                                        fontSize: 46.0,
                                        color: Color(0xffFFFDF7),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Image(
                                  image: AssetImage(
                                      "assets/images/panahkanan.png"),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: 40,
                          top: 140,
                          child: Text(
                            'Dzuhur',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Positioned(
                          right: 90,
                          top: 180,
                          child: InkWell(
                            onTap: () {
                              // showDialog(
                              //   context: context,
                              //   builder: (context) {
                              //     return Qibla();
                              //   },
                              // );
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.compass),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Arah Kiblat',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 120,
                    child: Container(
                      width: 150,
                      child: Text(
                        'Assalamulaikum User',
                        maxLines: 2,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}

class MyClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, 50);
    //tikungan pertama
    path.quadraticBezierTo(10, 70, 40, 70);
    path.quadraticBezierTo(40, 70, size.width / 2 - 30, 70);
    //tikunngan ke 2
    path.quadraticBezierTo(size.width / 2, 70, size.width / 2, 100);
    path.quadraticBezierTo(size.width / 2, 170, size.width / 2, 200);
    //tikungan ke 3
    path.quadraticBezierTo(size.width / 2, 220, size.width / 2 + 20, 220);
    path.quadraticBezierTo(size.width / 2 + 20, 220, size.width - 30, 220);
    //tikungan ke 4
    path.quadraticBezierTo(size.width, 220, size.width, 260);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return null;
  }
}
