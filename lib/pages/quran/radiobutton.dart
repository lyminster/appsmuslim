import 'package:appsmuslim/pages/quran/settingEditFolder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/bookmarksModel.dart';
import 'provider/bookmarkProvider.dart';

class RadioCheck extends StatefulWidget {
  final BookmarkFolder bookmarkdata;

  RadioCheck({this.bookmarkdata});

  @override
  _RadioCheckState createState() => _RadioCheckState();
}

class _RadioCheckState extends State<RadioCheck> {
  int group = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      title: Text(
        "Folder ${widget.bookmarkdata.namaFolder}",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      content: Container(
          height: 150,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Radio(
                    value: 1,
                    groupValue: group,
                    onChanged: (t) {
                      setState(() {
                        group = t;
                      });
                    },
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        group = 1;
                      });
                    },
                    child: new Text(
                      'Ganti Nama Folder',
                      style: new TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 2,
                    groupValue: group,
                    onChanged: (t) {
                      setState(() {
                        group = t;
                      });
                    },
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        group = 2;
                      });
                    },
                    child: new Text(
                      'Hapus Folder',
                      style: new TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text('BATAL'),
                  ),
                  FlatButton(
                    onPressed: () {
                      if (group == 1) {
                        Navigator.of(context).pop(true);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return EditFolder(
                              namaFolder: widget.bookmarkdata.namaFolder,
                              idfolder: widget.bookmarkdata.id,
                            );
                          },
                        );
                      } else if (group == 2) {
                        Navigator.of(context).pop(true);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                title: Text(
                                  'Hapus Folder?',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                content: Container(
                                  height: 150,
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          'Semua Bookmark yang ada di dalam Folder akan ikt terhapus.',
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
                                                  .removeFolder(
                                                      widget.bookmarkdata.id,
                                                      widget.bookmarkdata
                                                          .namaFolder);
                                              await Provider.of<BookmarkData>(
                                                      context,
                                                      listen: false)
                                                  .getAllFolder();
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
                      }
                    },
                    child: Text('YA'),
                  )
                ],
              )
            ],
          )),
    );
  }
}
