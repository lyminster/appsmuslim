import 'package:appsmuslim/pages/quran/ayaWidget.dart';
import 'package:appsmuslim/pages/quran/bookmarkWidget.dart';
import 'package:appsmuslim/pages/quran/listJuz.dart';
import 'package:appsmuslim/pages/quran/listSura.dart';
import 'package:appsmuslim/pages/quran/models/suraModel.dart';
import 'package:appsmuslim/pages/quran/provider/suraProvider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MainQuran extends StatefulWidget {
  @override
  _MainQuranState createState() => _MainQuranState();
}

class _MainQuranState extends State<MainQuran>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Al'Quran",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xffC11018),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        bottom: TabBar(
          indicatorColor: Colors.white,
          indicatorWeight: 5,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          labelColor: Colors.white,
          controller: controller,
          tabs: <Widget>[
            Tab(
              //icon: Icon(FontAwesomeIcons.quran),
              text: 'Sura',
            ),
            Tab(
              //icon: Icon(FontAwesomeIcons.solidBookmark),
              text: 'Juz',
            )
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.solidBookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookMarkWidget()),
              );
            },
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
        ],
      ),
      backgroundColor: Color(0xffF1F1F1),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          QuranListSura(),
          QuranListJuz(),
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final cities = [
    '123',
    '12345',
    '234123',
    '234',
    'sad',
    'qwe',
    'zxc',
    'sdf',
    'fgh',
  ];
  final List<Chapter> recentCities = [];
  @override
  String get searchFieldLabel => "Cari Nama Surah";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // todo : implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final ListSuraData surasData =
        Provider.of<ListSuraData>(context, listen: false);

    final List<Chapter> suggestList = query.isEmpty
        ? []
        : surasData.chaptersModel.chapters
            .where((p) =>
                p.nameSimple.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(FontAwesomeIcons.quran),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) {
              return AyaWidget(
                chapter: suggestList[index],
                isSura: true,
                juzNo: null,
              );
            },
          ));
        },
        title: RichText(
          text: TextSpan(
              text: suggestList[index].nameSimple.substring(0, query.length),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: suggestList[index].nameSimple.substring(query.length),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ]),
        ),
      ),
      itemCount: suggestList.length,
    );
  }
}
