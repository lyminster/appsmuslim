import 'package:appsmuslim/pages/hadist/provider/hadistdata.dart';
import 'package:appsmuslim/pages/hadist/listbab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListKitab extends StatefulWidget {
  @override
  _ListKitabState createState() => _ListKitabState();
}

class _ListKitabState extends State<ListKitab> {
  @override
  Widget build(BuildContext context) {
    final HadistDataProvider data = Provider.of<HadistDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('List Kitab'),
      ),
      backgroundColor: Color(0xffFFF8E2),
      body: ListView.builder(
        itemCount: data.datakitab.length,
        itemBuilder: (context, index) {
          return Container(
            color: index % 2 == 0 ? Color(0xffF5E6C9) : Color(0xffFFEBCE),
            height: 63,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListBab(
                            id: data.datakitab[index].id,
                          )),
                );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 9, 16, 9),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Color(0xffE1CEB1)),
                      height: 45,
                      width: 45,
                      child: Center(
                          child: Text(
                        (index + 1).toString(),
                        style: TextStyle(fontSize: 12),
                      )),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Text(
                        "${data.datakitab[index].nama}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
