import 'package:flutter/material.dart';

class IsiKomik extends StatefulWidget {
  final data;
  final data2;

  IsiKomik({this.data, this.data2});
  @override
  _IsiKomikState createState() => _IsiKomikState();
}

class _IsiKomikState extends State<IsiKomik> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Episode ${widget.data['No']}'),
      ),
      backgroundColor: Color(0xffF0F0F0),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: <Widget>[
                Image.network(widget.data['linkimg']),
                Container(
                  decoration: new BoxDecoration(
                    color: Color(0xFFCAF890),
                    borderRadius: new BorderRadius.vertical(
                        bottom: new Radius.elliptical(
                            MediaQuery.of(context).size.width, 100.0)),
                  ),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(18.0, 20.0, 18.0, 50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.data['kata1'],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.data['kata2'],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.data['kata3'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
                ),
                SizedBox(
                  height: 50,
                ),
                widget.data['No'] != '10'
                    ? Container(
                        width: 400, height: 530, child: nextEpi(widget.data2))
                    : Container(
                        child: Text('next episode belum ada'),
                      ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget nextEpi(data) {
  return Stack(
    children: <Widget>[
      Positioned(
        top: 20,
        right: 20,
        child: Container(
          width: 280,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(
              width: 1,
              color: Colors.grey[300],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Baca komik selanjutnya yuk!",
                  // data['kata1'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(120.0, 0.0, 20.0, 20.0),
                child: Text(
                  data['kata1'],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        top: 110,
        left: 10,
        child: Container(
          height: 140,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[700],
            image: DecorationImage(
              image: new AssetImage('assets/images/thumbkecil.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    ],
  );
}
