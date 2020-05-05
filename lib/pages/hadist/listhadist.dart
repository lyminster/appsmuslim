import 'package:appsmuslim/pages/hadist/model/hadistMenuModel.dart';
import 'package:appsmuslim/pages/hadist/provider/hadistdata.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ListHadist extends StatefulWidget {
  int id;
  ListHadist({this.id});
  @override
  _ListHadistState createState() => _ListHadistState();
}

class _ListHadistState extends State<ListHadist> {
  List<ListHadistData> datahadist = [];

  @override
  void initState() {
    //getData();
    super.initState();
    getdata();
  }

  getdata() async {
    // await Provider.of<HadistDataProvider>(context, listen: false).getdata();
    var data = await Provider.of<HadistDataProvider>(context, listen: false)
        .getbyidbab(widget.id);
    setState(() {
      datahadist = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Hadist ${widget.id}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.bookmark),
            onPressed: () {
              
            },
          ),
        ],
      ),
      backgroundColor: Color(0xffFFF8E2),
      body: ListView.builder(
        itemCount: datahadist.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              child: Text(
                "${datahadist[index].isi}",
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        },
      ),
    );
  }
}
