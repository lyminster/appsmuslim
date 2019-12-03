import 'package:flutter/material.dart';

class MainParenting extends StatefulWidget {
  @override
  _MainParentingState createState() => _MainParentingState();
}

class _MainParentingState extends State<MainParenting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
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
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                  blurRadius: 11.0,
                )
              ],
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Parenting menurut ajaran islam.",
                      style: TextStyle(fontSize: 15.0, letterSpacing: 1.2),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      height: 150.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: Colors.green,
                              child: Container(
                                  child: index == 3
                                      ? Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                "Artikle yang tepat untuk anak bunda?",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                "View More",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Text(
                                            "$index - ${index + 1} tahun",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 36.0),
                                          ),
                                        )),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
