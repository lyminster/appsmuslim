import 'package:appsmuslim/helpers/shimmer_helpers.dart';
import 'package:appsmuslim/pages/quran/ayaWidget.dart';
import 'package:appsmuslim/pages/quran/provider/juzProvider.dart';
import 'package:appsmuslim/pages/quran/provider/suraProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/juzModel.dart';

class QuranListJuz extends StatefulWidget {
  @override
  _QuranListJuzState createState() => _QuranListJuzState();
}

class _QuranListJuzState extends State<QuranListJuz> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    //await Provider.of<ListJuzData>(context, listen: false).getJuzs();
    //await Provider.of<ListJuzData>(context, listen: false).getChapters();
  }

  @override
  Widget build(BuildContext context) {
    final ListJuzData juzsData = Provider.of<ListJuzData>(context);

    return ListView.builder(
      itemCount: juzsData.isGettingJuzs ? 5 : juzsData.juzModel.juzs.length,
      itemBuilder: (context, index) {
        if (juzsData.isGettingJuzs) {
          return chapterDataCellShimmer();
        } else {
          var chapter = juzsData.juzModel?.juzs?.elementAt(index);
          return chapterDataCell(chapter);
        }
      },
    );
  }

  Widget chapterDataCell(Juz juz) {
    final ListSuraData surasData = Provider.of<ListSuraData>(context);

    if (juz == null) {
      return Container();
    }

    int firstSura = int.parse(juz.verseMapping.keys.first);
    int firstAya = int.parse(juz.verseMapping.values.first.split("-")[0]);

    var selectedChapter = surasData.chaptersModel.chapters.firstOrDefault(
      (v) => v.chapterNumber == firstSura && firstAya <= v.versesCount,
    );

    return Container(
      height: 63,
      color: juz.juzNumber % 2 == 0 ? Color(0xffFFFFFF) : Color(0xffF1F1F1),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return AyaWidget(
                  chapter: selectedChapter,
                  isSura: false,
                  juzNo: juz.juzNumber,
                );
              },
            ),
          );
        },
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Juz ${juz.juzNumber}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: Container(
          width: 175,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Mulai di',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                '${selectedChapter?.nameSimple} Ayat $firstAya',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
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
