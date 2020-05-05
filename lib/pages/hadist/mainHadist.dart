import 'package:appsmuslim/pages/hadist/homeHadist.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainHadist extends StatefulWidget {
  @override
  _MainHadistState createState() => _MainHadistState();
}

class _MainHadistState extends State<MainHadist> {
  @override
  var listMenu = [
    {"judul": "Baca", "subjudul": "dari Awal", "menu": "Quran"},
    {"judul": "Lanjut", "subjudul": "dari Ayat Terakhir", "menu": "Last"},
    {"judul": "Lihat", "subjudul": "Bookmark", "menu": "Bookmark"},
  ];

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 50.0, 50.0, 140.0),
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
                    bottomRight: Radius.circular(30)),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 80.0, 100.0, 0.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Kitab Hadist',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  ),
                ),
              ),
              Icon(
                FontAwesomeIcons.search,
                color: Colors.white,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 130.0, 0.0, 0.0),
          child: Container(
            height: 180,
            child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                scrollDirection: Axis.horizontal,
                itemCount: listMenu.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: index == 0
                        ? const EdgeInsets.fromLTRB(40.0, 0.0, 10.0, 0.0)
                        : const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    child: InkWell(
                      onTap: () {
                        switch (listMenu[index]['menu']) {
                          case "Quran":
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeHadist()),
                              );
                            }
                            break;
                        }
                      },
                      child: Container(
                        width: 165,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[400],
                              blurRadius: 11.0,
                            )
                          ],
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(45.0),
                            topLeft: Radius.circular(5.0),
                            bottomLeft: Radius.circular(45.0),
                            bottomRight: Radius.circular(5.0),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xffE5E5E5),
                              Color(0xffE9C586),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                listMenu[index]['judul'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                listMenu[index]['subjudul'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Expanded(
                                child: Text('gambar'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
