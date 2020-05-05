import 'package:appsmuslim/pages/quran/mainQuran.dart';
import 'package:appsmuslim/pages/quran/provider/bookmarkProvider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MainIkra extends StatefulWidget {
  @override
  _MainIkraState createState() => _MainIkraState();
}

class _MainIkraState extends State<MainIkra> {
  void initState() {
    super.initState();
    Provider.of<BookmarkData>(context, listen: false).getAllBookMarks();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Qur\'an",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2),
          ),
          SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainQuran()),
              );
            },
            child: Container(
              height: 220.0,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300],
                    blurRadius: 11.0,
                  )
                ],
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: AssetImage("assets/images/quran.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Color.fromRGBO(255, 255, 255, 0.55),
                              ),
                              width: MediaQuery.of(context).size.width * 0.58,
                              height: 40.0,
                              child: Center(
                                child: Text(
                                  "Baca Iqra",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Color.fromRGBO(255, 255, 255, 0.55),
                              ),
                              width: MediaQuery.of(context).size.width * 0.58,
                              height: 40.0,
                              child: Center(
                                child: Text(
                                  "Baca dari Awal",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Color.fromRGBO(255, 255, 255, 0.55),
                              ),
                              width: MediaQuery.of(context).size.width * 0.58,
                              height: 40.0,
                              child: Center(
                                child: Text(
                                  "Lanjut dari ayat",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.solidBookmark),
                                SizedBox(
                                  width: 11,
                                ),
                                Expanded(
                                  child: Consumer<BookmarkData>(
                                      builder: (context, book, _) {
                                    return book.bookmarks.length > 0
                                        ? Text(
                                            'Total Bookmark ${book.bookmarks.length}',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.2,
                                            ),
                                          )
                                        : Text(
                                            "Belum ada ayat yang tersimpan",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.2,
                                            ),
                                          );
                                  }),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
