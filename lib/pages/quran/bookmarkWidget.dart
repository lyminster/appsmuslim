import 'package:appsmuslim/pages/login/editpage.dart';
import 'package:appsmuslim/pages/quran/bookmarkisi.dart';
import 'package:appsmuslim/pages/quran/provider/bookmarkProvider.dart';
import 'package:appsmuslim/pages/quran/radiobutton.dart';
import 'package:appsmuslim/pages/quran/settingEditFolder.dart';
import 'package:appsmuslim/pages/quran/suraorjuz.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BookMarkWidget extends StatefulWidget {
  @override
  _BookMarkWidgetState createState() => _BookMarkWidgetState();
}

class _BookMarkWidgetState extends State<BookMarkWidget> {
  int group = 1;

  void initState() {
    super.initState();
    Provider.of<BookmarkData>(context, listen: false).getAllFolder();
    Provider.of<BookmarkData>(context, listen: false).getAllLastSeen();
  }

  @override
  Widget build(BuildContext context) {
    final BookmarkData data = Provider.of<BookmarkData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bookmark Qur`an",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Color(0xffC11018),
      ),
      backgroundColor: Color(0xffF1F1F1),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          'Terakhir Dibaca',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 16,
                        ),
                        Icon(FontAwesomeIcons.paperclip),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: data.isGettingData
                              ? Container(
                                  child: Text('Loading...'),
                                )
                              : Row(
                                  children: <Widget>[
                                    data.lastSeen.length == 0
                                        ? Text(
                                            'Belum ada yang ditandai',
                                            style: TextStyle(fontSize: 18),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return SuraJuzDialog(
                                                      islast: true,
                                                      surano: null,
                                                      juzno: null,
                                                      indexaya: null,
                                                      judul: "${data.lastSeen[0].suraName} Ayat ${data.lastSeen[0].aya.toString()}"
                                                    );
                                                  });
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  data.lastSeen[0].suraName,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  " : ${data.lastSeen[0].aya.toString()} (${data.lastSeen[0].jenis} ${data.lastSeen[0].sura.toString()})",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                        ),
                        // Text(
                        //   'Hapus',
                        //   style: TextStyle(fontSize: 12),
                        // ),
                        SizedBox(
                          width: 23,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            Container(
              height: 6,
              color: Color(0xffCBCBCB),
            ),
            Container(
              child: data.isGettingData
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.bookmarksTable.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 18.0, 8.0, 16.0),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return RadioCheck(
                                                bookmarkdata:
                                                    data.bookmarksTable[index],
                                              );
                                            });
                                      },
                                      child: Container(
                                        child: Row(
                                          children: <Widget>[
                                            Image.asset(
                                                'assets/images/folder.png'),
                                            SizedBox(
                                              width: 14,
                                            ),
                                            Text(
                                              data.bookmarksTable[index]
                                                  .namaFolder,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            IsiBookmark(
                              namaFolder: data.bookmarksTable[index].namaFolder,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 6,
                              color: Color(0xffCBCBCB),
                            ),
                          ],
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
