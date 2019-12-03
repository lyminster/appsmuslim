import 'package:appsmuslim/helpers/shimmer_helpers.dart';
import 'package:appsmuslim/pages/quran/provider/suraProvider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'models/suraModel.dart';

class MainQuran extends StatefulWidget {
  @override
  _MainQuranState createState() => _MainQuranState();
}

class _MainQuranState extends State<MainQuran> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await Provider.of<ListSuraData>(context, listen: false).getChapters();
  }

  @override
  Widget build(BuildContext context) {
    final ListSuraData surasData = Provider.of<ListSuraData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Al'Quran"),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.solidBookmark),
            onPressed: (){},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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
            )
          ],
        ),
      ),
    );
  }
}

Widget listSura(Chapter chapter) {
  if (chapter == null) {
    return Container();
  }

  return InkWell(
    onTap: () {},
    child: Container(
      padding: EdgeInsets.symmetric(
        vertical: 7.5,
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '${chapter.chapterNumber}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  chapter.nameSimple,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(chapter.translatedName.name),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              chapter.nameArabic,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    ),
  );
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
