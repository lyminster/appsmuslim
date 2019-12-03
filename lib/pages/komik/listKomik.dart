import 'package:flutter/material.dart';

class ListKomik extends StatefulWidget {
  @override
  _ListKomikState createState() => _ListKomikState();
}

class _ListKomikState extends State<ListKomik> {
  var listkomik = [
    {"No": "1", "Judul": "Episode 1", "Open": true},
    {"No": "2", "Judul": "Episode 2", "Open": true},
    {"No": "3", "Judul": "Episode 3", "Open": true},
    {"No": "4", "Judul": "Episode 4", "Open": true},
    {"No": "5", "Judul": "Episode 5", "Open": true},
    {"No": "6", "Judul": "Episode 6", "Open": false}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Komik"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: listkomik.length,
          itemBuilder: (contex, index) {
            return InkWell(
              onTap: () {
                print(listkomik[index]["Judul"]);
              },
              child: Container(
                color: listkomik[index]["Open"] ? Colors.white : Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            listkomik[index]["No"],
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                          Expanded(
                            child: Text(
                              listkomik[index]["Judul"],
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
