import 'package:appsmuslim/pages/ikra/listIkra.dart';
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
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 50.0, 50.0, 0.0),
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(
            //   boxShadow: [
            //     BoxShadow(
            //       color: Colors.grey[300],
            //       blurRadius: 11.0,
            //     )
            //   ],
            // ),
            child: Card(
              color: Color(0xffE1CEB1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 80.0, 85.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Belum lancar baca Al-Qur`an?',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListIkra()),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Baca IQRA dulu yuk',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(FontAwesomeIcons.chevronRight),
                    Icon(FontAwesomeIcons.chevronRight)
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
