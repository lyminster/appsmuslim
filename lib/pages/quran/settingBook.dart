import 'package:appsmuslim/pages/quran/models/suraModel.dart';
import 'package:appsmuslim/pages/quran/provider/bookmarkProvider.dart';
import 'package:appsmuslim/pages/quran/settingAddNewFolder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'models/ayaModel.dart';

class SettingBookmark extends StatefulWidget {
  final Aya aya;
  final Chapter chapter;
  final bool isSura;

  SettingBookmark(
      {@required this.aya, @required this.chapter, @required this.isSura});

  @override
  _SettingBookmarkState createState() => _SettingBookmarkState();
}

class _SettingBookmarkState extends State<SettingBookmark> {
  @override
  void initState() {
    super.initState();
    getalldata();
  }

  getalldata() async {
    await Provider.of<BookmarkData>(context, listen: false).getAllFolder();
  }

  Future showaddfolder() async {
    await showDialog(
      context: context,
      builder: (context) {
        return SettingAddFolder();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final BookmarkData data = Provider.of<BookmarkData>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: Container(
        height: 300,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).dialogBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Center(
                child: Text(
                  'Pilih Folder Bookmark',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: data.isGettingData
                              ? 1
                              : data.bookmarksTable.length,
                          itemBuilder: (context, index) {
                            return data.isGettingData
                                ? Container(
                                    child: Text('Loading'),
                                  )
                                : InkWell(
                                    onTap: () async {
                                      var bookmarkModel =
                                          await Provider.of<BookmarkData>(
                                                  context,
                                                  listen: false)
                                              .addBookmark(
                                                  widget.aya,
                                                  widget.chapter,
                                                  data.bookmarksTable[index]
                                                      .namaFolder,
                                                  widget.isSura
                                                      ? 'Sura'
                                                      : 'Juz');
                                      Navigator.of(context).pop(true);
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            Future.delayed(Duration(seconds: 3),
                                                () {
                                              Navigator.of(context).pop(true);
                                            });
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                              ),
                                              content: Container(
                                                height: 185,
                                                child: Column(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 26,
                                                    ),
                                                    Text(
                                                      '${widget.chapter.nameSimple} : Ayat ${widget.aya.aya}',
                                                      style: TextStyle(
                                                          fontSize: 24),
                                                    ),
                                                    SizedBox(
                                                      height: 25,
                                                    ),
                                                    Text(
                                                      'ditambahkan ke folder',
                                                      style: TextStyle(
                                                          fontSize: 24),
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    Text(
                                                      data.bookmarksTable[index]
                                                          .namaFolder,
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 26,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(FontAwesomeIcons.solidFolder),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            data.bookmarksTable[index]
                                                .namaFolder,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                          }),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                showaddfolder();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.folderPlus),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Buat Folder Baru',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       InkWell(
            //         onTap: () {
            //           Navigator.of(context).pop();
            //         },
            //         child: Container(
            //           height: 56,
            //           width: 120,
            //           decoration: BoxDecoration(
            //             border: Border.all(width: 1),
            //             borderRadius: BorderRadius.circular(7.0),
            //           ),
            //           child: Center(
            //               child: Text(
            //             'Batal',
            //             style: TextStyle(fontSize: 18),
            //           )),
            //         ),
            //       ),
            //       Container(
            //         height: 56,
            //         width: 120,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(7.0),
            //           color: Color(0xff271705),
            //         ),
            //         child: Center(
            //           child: Text(
            //             'Tambah',
            //             style: TextStyle(color: Colors.white, fontSize: 18),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
