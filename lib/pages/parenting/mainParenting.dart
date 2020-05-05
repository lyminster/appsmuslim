import 'package:appsmuslim/pages/parenting/formParenting.dart';
import 'package:appsmuslim/pages/parenting/listParenting.dart';
import 'package:flutter/material.dart';

class MainParenting extends StatefulWidget {
  @override
  _MainParentingState createState() => _MainParentingState();
}

class _MainParentingState extends State<MainParenting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Islami Parenting",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2),
          ),
          SizedBox(
            height: 10.0,
          ),
          Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 11.0,
                      )
                    ],
                  ),
                  child: Card(
                    color: Color(0xffC4C4C4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      height: 150.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(60.0),
                                    topLeft: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(60.0),
                                    bottomRight: Radius.circular(10.0),
                                  ),
                                ),
                                color: Color(0xffE5E5E5),
                                child: Container(
                                  child: index == 3
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FormParenting()),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(14.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  "Artikle yang tepat untuk anak bunda?",
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                                Text(
                                                  "View More",
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ListParenting()),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(14.0),
                                            child: Center(
                                              child: Text(
                                                "$index - ${index + 1} tahun",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 26.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
