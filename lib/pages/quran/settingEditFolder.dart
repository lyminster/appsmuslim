import 'package:appsmuslim/pages/quran/provider/bookmarkProvider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EditFolder extends StatefulWidget {
  final namaFolder;
  final idfolder;
  EditFolder({@required this.namaFolder , @required this.idfolder});

  @override
  _EditFolderState createState() => _EditFolderState();
}

class _EditFolderState extends State<EditFolder> {
  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final BookmarkData data = Provider.of<BookmarkData>(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      title: Text('Edit Folder ${widget.namaFolder}'),
      content: Container(
        height: 120,
        child: Column(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _textFieldController,
                decoration: InputDecoration(hintText: "Masukan Nama Folder"),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 46,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: Center(
                          child: Text(
                        'Batal',
                        style: TextStyle(fontSize: 18),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await data.updateFolder(_textFieldController.text,widget.idfolder);
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
                                    'Folder " ${widget.namaFolder} " telah di Ubah',
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
                    child: Container(
                      height: 46,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: Color(0xff271705),
                      ),
                      child: Center(
                        child: Text(
                          'Simpan',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
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
