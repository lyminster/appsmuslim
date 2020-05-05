import 'package:appsmuslim/pages/quran/ayaWidget.dart';
import 'package:appsmuslim/pages/quran/bookmarkWidget.dart';
import 'package:appsmuslim/pages/quran/mainQuran.dart';
import 'package:appsmuslim/pages/quran/models/suraModel.dart';
import 'package:appsmuslim/pages/quran/provider/juzProvider.dart';
import 'package:appsmuslim/pages/quran/provider/suraProvider.dart';
import 'package:appsmuslim/pages/quran/suraorjuz.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MainMenuQuran extends StatefulWidget {
  @override
  _MainMenuQuranState createState() => _MainMenuQuranState();
}

class _MainMenuQuranState extends State<MainMenuQuran> {
  @override
  var listMenu = [
    {"judul": "Baca", "subjudul": "dari Awal", "menu": "Quran", "gambar": "30"},
    {
      "judul": "Lanjut",
      "subjudul": "dari Ayat Terakhir",
      "menu": "Last",
      "gambar": "31"
    },
    {
      "judul": "Lihat",
      "subjudul": "Bookmark",
      "menu": "Bookmark",
      "gambar": "32"
    },
  ];

  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    await Provider.of<ListSuraData>(context, listen: false).getChapters();
    await Provider.of<ListJuzData>(context, listen: false).getJuzs();
  }

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 50.0, 0.0),
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
                color: Color(0xffC11018),
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.grey.withOpacity(0.025), BlendMode.modulate),
                  image: AssetImage('assets/images/patern.png'),
                  fit: BoxFit.fill,
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 40.0, 100.0, 0.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainQuran()),
                    );
                  },
                  child: Text(
                    'Al-Qur`an',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(),
                  );
                },
                child: Icon(
                  FontAwesomeIcons.search,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 90.0, 0.0, 0.0),
          child: Container(
            height: 200,
            child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // physics: NeverScrollableScrollPhysics(),
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
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return AyaWidget(
                                    chapter: Chapter(
                                        id: 1,
                                        chapterNumber: 1,
                                        bismillahPre: false,
                                        revelationOrder: 5,
                                        versesCount: 7,
                                        nameArabic: "الفاتحة",
                                        nameComplex: "Al-Fātiĥah",
                                        nameSimple: "Al-Fatihah",
                                        pages: [1, 1],
                                        translatedName: TranslatedName(
                                            languageName: "English",
                                            name: "The Opener")),
                                    isSura: true,
                                    juzNo: null,
                                  );
                                },
                              ));
                            }
                            break;
                          case "Bookmark":
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookMarkWidget()),
                              );
                            }
                            break;
                          case "Last":
                            {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SuraJuzDialog(
                                      islast: true,
                                      surano: null,
                                      juzno: null,
                                      indexaya: null,
                                      judul:null,
                                    );
                                  });
                            }
                            break;
                        }
                      },
                      child: Container(
                        height: 700,
                        width: 105,
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
                          // gradient: LinearGradient(
                          //   begin: Alignment.topCenter,
                          //   end: Alignment.bottomCenter,
                          //   colors: [
                          //     Color(0xffE5E5E5),
                          //     Color(0xffE9C586),
                          //   ],
                          // ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(5.0, 25.0, 5.0, 10.0),
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Card(
                                        elevation: 15.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(30),
                                            bottomRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(30),
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(30),
                                            bottomRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(30),
                                          ),
                                          child: Image.asset(
                                              'assets/images/image${listMenu[index]['gambar']}.png'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
