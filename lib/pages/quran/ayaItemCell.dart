import 'package:appsmuslim/pages/quran/models/ayaModel.dart';
import 'package:appsmuslim/pages/quran/models/suraModel.dart';
import 'package:appsmuslim/pages/quran/models/transModel.dart';
import 'package:appsmuslim/pages/quran/provider/audioProvider.dart';
import 'package:appsmuslim/pages/quran/provider/ayaProvider.dart';
import 'package:appsmuslim/pages/quran/provider/bookmarkProvider.dart';
import 'package:appsmuslim/pages/quran/provider/settingProvider.dart';
import 'package:appsmuslim/pages/quran/provider/suraProvider.dart';
import 'package:appsmuslim/pages/quran/settingBook.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:quiver/strings.dart';
import 'package:share/share.dart';

class AyaItemCell extends StatefulWidget {
  final Aya aya;
  // final List<Tuple2<TranslationDataKey, TranslationAya>> listTranslationsAya;
  final bool isSura;

  AyaItemCell(
      {@required this.aya,
      // @required this.listTranslationsAya,
      @required this.isSura});

  @override
  _AyaItemCellState createState() => _AyaItemCellState();
}

class _AyaItemCellState extends State<AyaItemCell> {
  Aya aya = Aya();
  // List<Tuple2<TranslationDataKey, TranslationAya>> listTranslationsAya = [];

  @override
  void initState() {
    setState(() {
      aya = widget.aya;
      // listTranslationsAya = widget.listTranslationsAya;
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bukaModalBawah(Aya aya, Chapter chapter, String terjemahan, String carabaca) {
    final AudioData audio = Provider.of<AudioData>(context, listen: false);

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 350,
            color: Color(0xFF737373),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '${chapter.nameSimple} ${chapter.chapterNumber}: Ayat ${aya.aya}',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.play),
                      title: Text('Play dari ayat ini'),
                      onTap: () {
                        // Provider.of<ListAyaData>(context, listen: false)
                        //     .jalanScroll();
                        Navigator.of(context).pop(true);
                        var noayat = int.parse(aya.ayaIndex) + 1;
                        audio.noAyat == noayat.toString() && audio.isPlay
                            ? audio.stop()
                            : audio.play(noayat.toString());
                      },
                    ),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.shareAlt),
                      title: Text('Bagikan ayat'),
                      onTap: () {
                        Share.share('''${aya.text}
                            ${carabaca}
                            ${terjemahan}''');
                      },
                    ),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.solidCopy),
                      title: Text('Salin ayat'),
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: '''${aya.text}
                            ${carabaca}
                            ${terjemahan}'''));
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (context) {
                              Future.delayed(Duration(seconds: 3), () {
                                Navigator.of(context).pop(true);
                              });
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                content: Container(
                                  height: 100,
                                  child: Center(
                                    child: Text(
                                      'Ayat ${aya.aya} telah dicopy.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.bookmark_border,
                        size: 30.0,
                      ),
                      title: Text('Tambahkan ke bookmark'),
                      onTap: () async {
                        // if (!aya.isBookmarked) {
                        //   var bookmarkModel = await Provider.of<BookmarkData>(
                        //           context,
                        //           listen: false)
                        //       .addBookmark(
                        //           aya, chapter, widget.isSura ? 'Sura' : 'Juz');

                        //   setState(() {
                        //     aya.bookmarksModel = bookmarkModel;
                        //     aya.isBookmarked = true;
                        //   });
                        // } else {
                        //   await Provider.of<BookmarkData>(context, listen: false)
                        //       .removeBookmark(aya.bookmarksModel.id);

                        //   setState(() {
                        //     aya.isBookmarked = false;
                        //   });
                        // }
                        showbookDialog(aya, chapter, widget.isSura);
                        // Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.paperclip),
                      title: Text('Tandai terakhir baca'),
                      onTap: () {
                        Provider.of<BookmarkData>(context, listen: false)
                            .addLastSeen(aya, chapter, '',
                                widget.isSura ? 'Sura' : 'Juz');
                        Navigator.of(context).pop(true);
                        showDialog(
                            context: context,
                            builder: (context) {
                              Future.delayed(Duration(seconds: 3), () {
                                Navigator.of(context).pop(true);
                              });
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                content: Container(
                                  height: 100,
                                  child: Center(
                                    child: Text(
                                      'Ayat Terakhir Telah di simpan.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future showbookDialog(Aya aya, Chapter chapter, bool isSura) async {
    await showDialog(
      context: context,
      builder: (context) {
        return SettingBookmark(aya: aya, chapter: chapter, isSura: isSura);
      },
    ).then((val) {
      setState(() {
        aya.isBookmarked = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ListAyaData ayaData = Provider.of<ListAyaData>(context);
    final ListSuraData chapData = Provider.of<ListSuraData>(context);

    if (aya == null) {
      return Container();
    }

    // List<Widget> listTranslationWidget = [];
    // for (var translationAya in listTranslationsAya) {
    //   listTranslationWidget.add(
    //     Column(
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: <Widget>[
    //         SizedBox.fromSize(
    //           size: Size.fromHeight(10),
    //         ),
    // Container(
    //   child: Consumer<SettingValues>(builder: (context, setting, _) {
    //     return ayaData.trans
    //         ? Text(
    //             '${translationAya.item1.name}',
    //             style: TextStyle(
    //               fontWeight: FontWeight.w600,
    //               fontSize: setting.transText,
    //             ),
    //           )
    //         : Text('');
    //   }),
    // ),
    // SizedBox.fromSize(
    //   size: Size.fromHeight(1),
    // ),
    //         Container(
    //           child: Consumer<SettingValues>(builder: (context, setting, _) {
    //             return ayaData.trans
    //                 ? Text(
    //                     translationAya.item2.text,
    //                     textAlign: TextAlign.right,
    //                     style: TextStyle(
    //                       fontSize: setting.transText,
    //                     ),
    //                   )
    //                 : Text('');
    //           }),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    return InkWell(
      onLongPress: () {
        // bukaModalBawah(aya, chapData.getcurrentchapter(aya.sura),
        //     listTranslationsAya[0].item2.text);
        bukaModalBawah(aya, chapData.getcurrentchapter(aya.sura), aya.indoText,
            aya.readText);
      },
      onTap: () {
        ayaData.tutuptrans();
      },
      child: Container(
        color: int.parse(aya.ayaIndex) % 2 == 0
            ? Color(0xffF1F1F1)
            : Color(0xffFFFFFF),
        padding: EdgeInsets.only(
          left: 15,
          top: 15,
          right: 20,
          bottom: 25,
        ),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      int.parse(aya.aya) == 1
                          ? Container(
                              padding: EdgeInsets.only(
                                top: 10,
                                bottom: 25,
                              ),
                              child: Text(
                                '${Provider.of<ListSuraData>(context).getname(aya.sura)}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            )
                          : Container(),
                      // Bismillah
                      !isBlank(aya.bismillah)
                          ? Container(
                              padding: EdgeInsets.only(
                                top: 10,
                                bottom: 25,
                              ),
                              child: Text(
                                'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 40, color: Color(0xff73582E)),
                              ),
                            )
                          : Container(),

                      // 1
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     Container(
                      //       width: 50,
                      //       height: 50,
                      //       child: Stack(
                      //         children: <Widget>[
                      //           Image.asset('assets/images/framenum.png'),
                      //           Center(
                      //             child: Text(
                      //               aya.aya,
                      //               style: TextStyle(
                      //                   fontSize: 18, color: Colors.white),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     InkWell(
                      //       onTap: () async {
                      //         // await showDialogActionButtons(
                      //         //     aya, ayaData.currentChapter);
                      //       },
                      //       child: Container(
                      //         child: aya.isBookmarked
                      //             ? Icon(
                      //                 Icons.bookmark,
                      //                 size: 30.0,
                      //               )
                      //             : Icon(
                      //                 Icons.bookmark_border,
                      //                 size: 30.0,
                      //               ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox.fromSize(
                      //   size: Size.fromHeight(
                      //     15,
                      //   ),
                      // ),
                      // 2
                      Consumer<SettingValues>(builder: (context, setting, _) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 50,
                              child: Stack(
                                children: <Widget>[
                                  aya.isBookmarked
                                      ? Center(
                                          child: Image.asset(
                                              'assets/images/bookmark_Number.png'),
                                        )
                                      : Image.asset(
                                          'assets/images/NumberFrame.png'),
                                  Center(
                                    child: Text(
                                      aya.aya,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Text(
                                aya.text,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: setting.arabicText,
                                  fontFamily: 'KFGQPC Uthman Taha Naskh',
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                      Container(
                        child: Consumer<SettingValues>(
                            builder: (context, setting, _) {
                          return ayaData.trans
                              ? Text(
                                  aya.readText,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: setting.transText,
                                  ),
                                )
                              : Text('');
                        }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Consumer<SettingValues>(
                            builder: (context, setting, _) {
                          return ayaData.trans
                              ? Text(
                                  aya.indoText,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: setting.transText,
                                  ),
                                )
                              : Text('');
                        }),
                      ),
                      //]..addAll(listTranslationWidget),
                    ]),
                // SizedBox(
                //   height: 10.0,
                // ),
                // Container(
                //   decoration: BoxDecoration(
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey[300],
                //         blurRadius: 11.0,
                //       )
                //     ],
                //   ),
                //   child: Card(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10.0),
                //     ),
                //     child: Padding(
                //       padding:
                //           const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 12.0),
                //       child: Row(
                //         children: <Widget>[
                //           SizedBox(
                //             width: 30.0,
                //           ),
                //           Expanded(
                //             child: Consumer<AudioData>(
                //                 builder: (context, audio, _) {
                //               return InkWell(
                //                   onTap: () {
                //                     audio.noAyat == aya.ayaIndex && audio.isPlay
                //                         ? audio.stop()
                //                         : audio.play(aya.ayaIndex);
                //                   },
                //                   child: audio.noAyat == aya.ayaIndex &&
                //                           audio.isPlay
                //                       ? Icon(
                //                           FontAwesomeIcons.stop,
                //                           size: 25.0,
                //                         )
                //                       : Icon(
                //                           FontAwesomeIcons.play,
                //                           size: 25.0,
                //                         ));
                //             }),
                //           ),
                //           InkWell(
                //             onTap: () {
                //               Share.share(
                //                   'check out my website https://example.com');
                //             },
                //             child: Icon(
                //               FontAwesomeIcons.shareAlt,
                //               size: 25.0,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future showDialogActionButtons(Aya aya, Chapter chapter) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          title:
              Text('${chapter.nameSimple} ${chapter.chapterNumber}:${aya.aya}'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                onPressed: () async {
                  if (!aya.isBookmarked) {
                    // var bookmarkModel =
                    //     await Provider.of<BookmarkData>(context, listen: false)
                    //         .addBookmark(
                    //             aya, chapter, widget.isSura ? 'Sura' : 'Juz');

                    // setState(() {
                    //   aya.bookmarksModel = bookmarkModel;
                    //   aya.isBookmarked = true;
                    // });
                  } else {
                    await Provider.of<BookmarkData>(context, listen: false)
                        .removeBookmark(aya.bookmarksModel.id);

                    setState(() {
                      aya.isBookmarked = false;
                    });
                  }
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.bookmark,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
