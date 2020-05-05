import 'package:appsmuslim/helpers/shimmer_helpers.dart';
import 'package:appsmuslim/pages/quran/ayaItemCell.dart';
import 'package:appsmuslim/pages/quran/models/ayaModel.dart';
import 'package:appsmuslim/pages/quran/models/juzModel.dart';
import 'package:appsmuslim/pages/quran/models/transModel.dart';
import 'package:appsmuslim/pages/quran/provider/ayaProvider.dart';
import 'package:appsmuslim/pages/quran/provider/juzProvider.dart';
import 'package:appsmuslim/pages/quran/provider/settingProvider.dart';
import 'package:appsmuslim/pages/quran/provider/suraProvider.dart';
import 'package:appsmuslim/pages/quran/settingWidget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:appsmuslim/pages/quran/models/suraModel.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class AyaWidget extends StatefulWidget {
  final Chapter chapter;
  final isSura;
  final juzNo;
  final indexaya;

  AyaWidget(
      {@required this.chapter,
      @required this.isSura,
      this.juzNo,
      this.indexaya});

  @override
  _AyaWidgetState createState() => _AyaWidgetState();
}

class _AyaWidgetState extends State<AyaWidget>
    with SingleTickerProviderStateMixin {
  @override
  TabController controller;
  List<Tab> myTabs;
  var kebalik;
  var arrChap;
  var noinde;

  void initState() {
    //untuk sura
    if (widget.isSura) {
      arrChap = Provider.of<ListSuraData>(context, listen: false).chaptersModel;
      var arr = arrChap.chapters.toList();
      kebalik = arr.reversed.toList();

      for (int i = 0; i < kebalik.length; i++) {
        if (kebalik[i].nameSimple == widget.chapter.nameSimple) {
          noinde = i;
        }
      }

      controller = new TabController(
          vsync: this, length: kebalik.length, initialIndex: noinde);
      myTabs = List.generate(
        kebalik.length,
        (index) => Tab(
            text:
                "${kebalik[index].nameSimple} (${kebalik[index].chapterNumber})"),
      );
    }
    //untuk juz
    else {
      arrChap = Provider.of<ListJuzData>(context, listen: false).juzModel;
      kebalik = arrChap.juzs.reversed.toList();

      for (int i = 0; i < kebalik.length; i++) {
        if (kebalik[i].juzNumber == widget.juzNo) {
          noinde = i;
        }
      }

      controller = new TabController(
          vsync: this, length: kebalik.length, initialIndex: noinde);
      myTabs = List.generate(
        kebalik.length,
        (index) => Tab(text: "Juz ${kebalik[index].juzNumber}"),
      );
    }

    super.initState();
  }

  Future showSettingsDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return SettingQuran();
      },
    );
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
        title: widget.isSura
            ? Text(
                widget.chapter.nameSimple,
                style: TextStyle(color: Colors.white),
              )
            : Text(
                "Juz ${widget.juzNo}",
                style: TextStyle(color: Colors.white),
              ),
        bottom: TabBar(
          indicatorColor: Colors.white,
          indicatorWeight: 5,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          labelColor: Colors.white,
          isScrollable: true,
          controller: controller,
          tabs: myTabs,
        ),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Color(0xffB80707),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.cog),
            onPressed: () async {
              await showSettingsDialog();
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: controller,
        children: List<Widget>.generate(kebalik.length, (int index) {
          return widget.isSura
              ? AyaAwal(
                  chapter: kebalik[index],
                  juz: null,
                  isSura: true,
                  indexaya: widget.indexaya,
                )
              : AyaAwal(
                  chapter: widget.chapter,
                  juz: kebalik[index],
                  isSura: false,
                  indexaya: widget.indexaya,
                );
        }),
      ),
    );
  }
}

Widget createAyaItemCellShimmer() {
  return ShimmerHelpers.createShimmer(
    child: Container(
      padding: EdgeInsets.only(
        left: 15,
        top: 15,
        right: 20,
        bottom: 25,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // 1
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 16,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert),
              ),
            ],
          ),
          // 2
          Container(
            height: 18,
            color: Colors.white,
          ),
        ],
      ),
    ),
  );
}

Widget createListAya(number, Aya aya, bool isSura) {
  return AyaItemCell(aya: aya, isSura: isSura);
}

// Widget createListAya3( number ,Aya aya,
//     Iterable<Tuple2<TranslationDataKey, TranslationAya>> listTranslationsAya , bool isSura) {
//   return AyaItemCell(
//       aya: aya, listTranslationsAya: listTranslationsAya.toList() , isSura : isSura);
// }

Widget createListAya2(Aya aya,
    Iterable<Tuple2<TranslationDataKey, TranslationAya>> listTranslationsAya) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                '1',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(FontAwesomeIcons.ellipsisV),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Consumer<SettingValues>(builder: (context, setting, _) {
          return Text(
            'Bahasa arab yang akan di keluarkan',
            style: TextStyle(
              fontSize: setting.arabicText,
              fontWeight: FontWeight.bold,
            ),
          );
        }),
        SizedBox(
          height: 10.0,
        ),
        Consumer<SettingValues>(builder: (context, setting, _) {
          return Text(
            'Bahasa Indonesia',
            style: TextStyle(
              fontSize: setting.transText,
              fontWeight: FontWeight.bold,
            ),
          );
        }),
        Consumer<SettingValues>(builder: (context, setting, _) {
          return Text(
            'asdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd',
            style: TextStyle(
              fontSize: setting.transText,
              fontWeight: FontWeight.w400,
            ),
          );
        }),
        SizedBox(
          height: 10.0,
        ),
        Consumer<SettingValues>(builder: (context, setting, _) {
          return Text(
            'Bahasa Inggris',
            style: TextStyle(
              fontSize: setting.transText,
              fontWeight: FontWeight.bold,
            ),
          );
        }),
        Consumer<SettingValues>(builder: (context, setting, _) {
          return Text(
            'asdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd',
            style: TextStyle(
              fontSize: setting.transText,
              fontWeight: FontWeight.w400,
            ),
          );
        }),
      ],
    ),
  );
}

class AyaAwal extends StatefulWidget {
  final Chapter chapter;
  final Juz juz;
  final isSura;
  final indexaya;

  AyaAwal({this.chapter, this.juz, this.isSura, this.indexaya});
  @override
  _AyaAwalState createState() => _AyaAwalState();
}

class _AyaAwalState extends State<AyaAwal> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  var number;
  void initState() {
    super.initState();
    if (widget.isSura) {
      getdata();
    } else {
      getdataJuz();
    }
    getnumber();
    if (widget.indexaya != null && widget.isSura) {
      jumpto();
    }
  }

  jumpto() async {
    Future.delayed(Duration(milliseconds: 500), () {
      itemScrollController.jumpTo(index: widget.indexaya - 1);
    });
  }

  getnumber() {
    if (widget.isSura) {
      number = widget.chapter.chapterNumber;
    } else {
      number = widget.juz.juzNumber;
    }
  }

  getdata() async {
    await Provider.of<ListAyaData>(context, listen: false)
        .getAya(widget.chapter);
  }

  getdataJuz() {
    Provider.of<ListAyaData>(context, listen: false).kosongkandata();

    List<String> where = [];
    List<int> suras = [];
    widget.juz.verseMapping.forEach((k, v) => {
          suras.add(int.parse(k)),
          where.add(
              'CAST(suraId as INTEGER) = ${int.parse(k)} and CAST(verseID as INTEGER) >= ${int.parse(v.split("-")[0])} and CAST(verseID as INTEGER) <= ${int.parse(v.split("-")[1])}')
        });
    Provider.of<ListAyaData>(context, listen: false)
        .getAyaJuz(widget.juz, where, suras);

    Future.delayed(Duration(milliseconds: 500), () {
      var listaya = Provider.of<ListAyaData>(context, listen: false).listAya;
      for (int i = 0; i < listaya.length; i++) {
        if (listaya[i].sura == widget.chapter.chapterNumber.toString() &&
            listaya[i].aya == widget.indexaya.toString()) {
          Future.delayed(Duration(milliseconds: 500), () {
            itemScrollController.jumpTo(index: i);
          });
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ListAyaData ayaData = Provider.of<ListAyaData>(context);

    return ScrollablePositionedList.builder(
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
      itemCount: ayaData.isGettingAya ? 5 : (ayaData?.listAya?.length ?? 0),
      itemBuilder: (context, index) {
        if (ayaData.isGettingAya) {
          return createAyaItemCellShimmer();
        }
        Aya aya = ayaData?.listAya?.elementAt(
          index,
        );
        // var listTranslationAya = ayaData?.translations?.entries?.toList();
        // listTranslationAya.sort((a, b) => a.key.name.compareTo(b.key.name));
        // return createListAya(
        //   number,
        //   aya,
        //   listTranslationAya.map(
        //     (v) {
        //       return Tuple2<TranslationDataKey, TranslationAya>(
        //         v.key,
        //         v.value.elementAt(index),
        //       );
        //     },
        //   ),
        //   widget.isSura
        // );
        return createListAya(number, aya, widget.isSura);
      },
    );
  }
}
