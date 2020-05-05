import 'package:appsmuslim/helpers/shimmer_helpers.dart';
import 'package:appsmuslim/pages/quran/ayaWidget.dart';
import 'package:appsmuslim/pages/quran/models/suraModel.dart';
import 'package:appsmuslim/pages/quran/provider/suraProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuranListSura extends StatefulWidget {
  @override
  _QuranListSuraState createState() => _QuranListSuraState();
}

class _QuranListSuraState extends State<QuranListSura> {
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final ListSuraData surasData = Provider.of<ListSuraData>(context);

    return Column(
      children: <Widget>[
        
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Container(
        //     decoration: BoxDecoration(
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.grey[300],
        //           blurRadius: 11.0,
        //         )
        //       ],
        //     ),
        //     child: InkWell(
        //       onTap: () {
        //         showSearch(
        //           context: context,
        //           delegate: CustomSearchDelegate(),
        //         );
        //       },
        //       child: Card(
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(12.0),
        //         ),
        //         child: Padding(
        //           padding: const EdgeInsets.all(10.0),
        //           child: Row(
        //             children: <Widget>[
        //               Expanded(
        //                 child: Text(
        //                   'Search Sura...',
        //                   style: TextStyle(
        //                     fontSize: 18.0,
        //                     fontWeight: FontWeight.w400,
        //                   ),
        //                 ),
        //               ),
        //               Icon(FontAwesomeIcons.search),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        Expanded(
          child: ListView.builder(
            itemCount: surasData.isGettingChapters
                ? 5
                : surasData.chaptersModel.chapters.length,
            itemBuilder: (context, index) {
              if (surasData.isGettingChapters) {
                return chapterDataCellShimmer();
              } else {
                var chapter =
                    surasData.chaptersModel?.chapters?.elementAt(index);
                return listSura(chapter);
              }
            },
          ),
        )
      ],
    );
  }

  Widget listSura(Chapter chapter) {
    if (chapter == null) {
      return Container();
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) {
            return AyaWidget(
              chapter: chapter,
              isSura: true,
              juzNo: 0,
            );
          },
        ));
      },
      child: Container(
        height: 63,
        color: chapter.chapterNumber % 2 == 0
            ? Color(0xffFFFFFF)
            : Color(0xffF1F1F1),
        padding: EdgeInsets.symmetric(
          vertical: 7.5,
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                '${chapter.chapterNumber}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    chapter.nameSimple,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    "${chapter.translatedName.name}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    " | ${chapter.versesCount.toString()} Ayat",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget chapterDataCellShimmer() {
  return ShimmerHelpers.createShimmer(
    child: InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 7.5,
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: 18,
                height: 18,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: 20,
                    color: Colors.white,
                  ),
                  SizedBox.fromSize(size: Size.fromHeight(5)),
                  Container(
                    height: 16,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                height: 24,
                width: 75,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
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
