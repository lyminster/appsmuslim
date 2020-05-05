import 'package:appsmuslim/pages/quran/models/suraModel.dart';
import 'package:appsmuslim/pages/quran/provider/ayaProvider.dart';
import 'package:appsmuslim/pages/quran/provider/bookmarkProvider.dart';
import 'package:appsmuslim/pages/quran/provider/juzProvider.dart';
import 'package:appsmuslim/pages/quran/provider/suraProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'ayaWidget.dart';

class SuraJuzDialog extends StatefulWidget {
  final islast;
  final surano;
  final juzno;
  final indexaya;
  final judul;

  SuraJuzDialog(
      {@required this.islast,
      @required this.surano,
      @required this.juzno,
      this.indexaya,
      this.judul});

  @override
  _SuraJuzDialogState createState() => _SuraJuzDialogState();
}

class _SuraJuzDialogState extends State<SuraJuzDialog> {
  void initState() {
    super.initState();
    Provider.of<BookmarkData>(context, listen: false).getAllLastSeen();
  }

  @override
  Widget build(BuildContext context) {
    final BookmarkData databook = Provider.of<BookmarkData>(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      title: Center(
        child: widget.islast ? Text('${databook.lastSeen[0].suraName} Ayat ${databook.lastSeen[0].aya}') :  Text('${widget.judul}'),
      ),
      content: Container(
          height: 120,
          child: Column(
            children: <Widget>[
              Text('Lihat Sebagai'),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                      onTap: () async {
                        if (widget.islast) {
                          Chapter datachapter = await Provider.of<ListSuraData>(
                                  context,
                                  listen: false)
                              .getcurrentchapter(
                                  databook.lastSeen[0].sura.toString());
                          Navigator.of(context).pop();

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) {
                              return AyaWidget(
                                chapter: datachapter,
                                isSura: true,
                                juzNo: null,
                                indexaya: databook.lastSeen[0].aya,
                              );
                            },
                          ));
                        } else {
                          Chapter datachapter = await Provider.of<ListSuraData>(
                                  context,
                                  listen: false)
                              .getcurrentchapter(widget.surano.toString());
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) {
                              return AyaWidget(
                                chapter: datachapter,
                                isSura: true,
                                juzNo: null,
                                indexaya: widget.indexaya,
                              );
                            },
                          ));
                        }
                      },
                      child: Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.fileAlt),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Sura'),
                        ],
                      ))),
                  InkWell(
                      onTap: () async {
                        if (widget.islast) {
                          Chapter datachapter = await Provider.of<ListSuraData>(
                                  context,
                                  listen: false)
                              .getcurrentchapter(
                                  databook.lastSeen[0].sura.toString());
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) {
                              return AyaWidget(
                                chapter: datachapter,
                                isSura: false,
                                juzNo: databook.lastSeen[0].juzNumber,
                                indexaya: databook.lastSeen[0].aya,
                              );
                            },
                          ));
                        } else {
                          Chapter datachapter = await Provider.of<ListSuraData>(
                                  context,
                                  listen: false)
                              .getcurrentchapter(widget.surano.toString());
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) {
                              return AyaWidget(
                                chapter: datachapter,
                                isSura: false,
                                juzNo: widget.juzno,
                                indexaya: widget.indexaya,
                              );
                            },
                          ));
                        }
                      },
                      child: Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.fileAlt),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Juz'),
                        ],
                      ))),
                ],
              ),
            ],
          )),
    );
  }
}
