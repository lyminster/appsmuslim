import 'package:appsmuslim/pages/quran/provider/bookmarkProvider.dart';
import 'package:appsmuslim/pages/quran/suraorjuz.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'models/bookmarksModel.dart';

class IsiBookmark extends StatefulWidget {
  final namaFolder;

  IsiBookmark({@required this.namaFolder});

  @override
  _IsiBookmarkState createState() => _IsiBookmarkState();
}

class _IsiBookmarkState extends State<IsiBookmark> {
  List<BookmarksModel> bookmarks = [];

  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    bookmarks = await Provider.of<BookmarkData>(context, listen: false)
        .getAllBookMarksdarifolder(widget.namaFolder);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: bookmarks.length == 0 ? 1 : bookmarks.length,
      itemBuilder: (context, index) {
        return bookmarks.length == 0
            ? Container(
                child: Center(child: Text('Tidak ada Bookmark')),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SuraJuzDialog(
                                    islast: false,
                                    surano: bookmarks[index].sura,
                                    juzno: bookmarks[index].juzNumber,
                                    indexaya: bookmarks[index].aya,
                                    judul: "${bookmarks[index].suraName} Ayat ${bookmarks[index].aya.toString()}",
                                    );
                              });
                        },
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  title: Text(
                                    'Hapus ${bookmarks[index].suraName} ayat ${bookmarks[index].aya.toString()}?',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  content: Container(
                                    height: 170,
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'Menghapus bookmark ayat ini saja tidak akan menghapus bookmark lainnya.',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(true);
                                              },
                                              child: Text('BATAL'),
                                            ),
                                            FlatButton(
                                              onPressed: () async {
                                                await Provider.of<BookmarkData>(
                                                        context,
                                                        listen: false)
                                                    .removeBookmark(
                                                        bookmarks[index].id);
                                                var data = await Provider.of<
                                                            BookmarkData>(
                                                        context,
                                                        listen: false)
                                                    .getAllBookMarksdarifolder(
                                                        widget.namaFolder);
                                                setState(() {
                                                  bookmarks = data;
                                                });
                                                Navigator.of(context).pop(true);
                                              },
                                              child: Text('YAKIN'),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Row(
                          children: <Widget>[
                            Text(
                              bookmarks[index].suraName,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              " : ${bookmarks[index].aya.toString()} (${bookmarks[index].jenis} ${bookmarks[index].sura.toString()} ${bookmarks[index].juzNumber.toString()})",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Text(DateFormat('yyyy-MM-dd')
                    //     .format(data.bookmarks[index].insertTime)
                    //     .toString()),
                    // InkWell(
                    //   onTap: () async {
                    //     await Provider.of<BookmarkData>(context, listen: false)
                    //         .removeBookmark(bookmarks[index].id);
                    //     var data = await Provider.of<BookmarkData>(context,
                    //             listen: false)
                    //         .getAllBookMarksdarifolder(widget.namaFolder);
                    //     // setState(() {
                    //     //   bookmarks = data;
                    //     // });
                    //   },
                    //   child: Text(
                    //     'Hapus',
                    //     style: TextStyle(fontSize: 12),
                    //   ),
                    // ),
                    SizedBox(
                      width: 23,
                    ),
                  ],
                ),
              );
      },
    );
  }
}
