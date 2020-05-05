import 'package:appsmuslim/pages/hadist/listhadist.dart';
import 'package:appsmuslim/pages/hadist/model/hadistMenuModel.dart';
import 'package:appsmuslim/pages/hadist/provider/hadistdata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListBab extends StatefulWidget {
  int id;
  ListBab({this.id});
  @override
  _ListBabState createState() => _ListBabState();
}

class _ListBabState extends State<ListBab> {
  List<ListBabData> databab = [];

  @override
  void initState() {
    //getData();
    super.initState();
    getdata();
  }

  getdata() async {
    // await Provider.of<HadistDataProvider>(context, listen: false).getdata();
    var data = await Provider.of<HadistDataProvider>(context, listen: false)
        .getbyidkitab(widget.id);
    setState(() {
      databab = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Bab ${widget.id}'),
      ),
      backgroundColor: Color(0xffFFF8E2),
      body: ListView.builder(
        itemCount: databab.length,
        itemBuilder: (context, index) {
          return Container(
            color: index % 2 == 0 ? Color(0xffF5E6C9) : Color(0xffFFEBCE),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListHadist(
                            id: databab[index].id,
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
                        "${databab[index].nama}",
                        style: TextStyle(fontSize: 20),
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
