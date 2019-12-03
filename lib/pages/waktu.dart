import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WaktuSolat extends StatefulWidget {
  @override
  _WaktuSolatState createState() => _WaktuSolatState();
}

class _WaktuSolatState extends State<WaktuSolat> {
  final List<String> litems = [
    'Imsak',
    'Subuh',
    'Terbit',
    'Dzuhur',
    'Ashar',
    'Maghrib',
    'Isya'
  ];
  var on = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Waktu Solat"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Kamis, 14 Nov 2019",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Icon(
                    FontAwesomeIcons.caretRight,
                    size: 50.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () {},
                    child: Icon(
                      FontAwesomeIcons.forward,
                      size: 40.0,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                thickness: 2.0,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: litems.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[300],
                                blurRadius: 11.0,
                              )
                            ],
                          ),
                          child: Card(
                            color: index == 4 ? Colors.green : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      litems[index],
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "3:30",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300],
                              blurRadius: 30.0,
                            )
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              on = !on;
                              print(on);
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Icon(
                                on
                                    ? FontAwesomeIcons.volumeUp
                                    : FontAwesomeIcons.volumeMute,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
