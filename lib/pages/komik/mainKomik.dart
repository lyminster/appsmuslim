import 'package:appsmuslim/pages/komik/listKomik.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainKomik extends StatefulWidget {
  @override
  _MainKomikState createState() => _MainKomikState();
}

class _MainKomikState extends State<MainKomik> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 50.0, 50.0, 0.0),
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(
            //   boxShadow: [
            //     BoxShadow(
            //       color: Colors.grey[300],
            //       blurRadius: 11.0,
            //     )
            //   ],
            // ),
            child: Card(
              color: Color(0xffB80707),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 80.0, 85.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Komik Islami',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 130.0, 20.0, 0.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListKomik()),
              );
            },
            child: Container(
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                    child: Image.asset('assets/images/thumbdepan.png'),
                  ),
                  Positioned(
                    right: -125,
                    bottom: 15,
                    left: MediaQuery.of(context).size.width / 2.5,
                    child: Icon(
                      FontAwesomeIcons.angleDoubleRight,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
