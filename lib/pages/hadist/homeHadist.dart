import 'package:appsmuslim/pages/hadist/listkitab.dart';
import 'package:appsmuslim/pages/hadist/model/hadistMenuModel.dart';
import 'package:appsmuslim/pages/hadist/provider/hadistdata.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeHadist extends StatefulWidget {
  @override
  _HomeHadistState createState() => _HomeHadistState();
}

class _HomeHadistState extends State<HomeHadist> {
  List<HadistMenu> menuhadist = <HadistMenu>[
    HadistMenu(isExpanded: false, judul: 'Terakhir Di Baca'),
    HadistMenu(isExpanded: false, judul: 'Bookmark'),
    HadistMenu(isExpanded: true, judul: 'Kumpulan Kitab Hadist')
  ];

  bool trakhirbaca = false;
  bool bookmark = false;
  bool kitab = true;
  var listHadist = [
    {"judul": "Bukhari", "total": 7008},
    // {"judul": "Muslim", "total": 5362},
    // {"judul": "Abu Daud", "total": 4590},
    // {"judul": "Tirmidzi", "total": 3891},
  ];
  @override
  void initState() {
    //getData();
    super.initState();
    getdata();
  }
  getdata() async {
    await Provider.of<HadistDataProvider>(context, listen: false).getdata();
  }
  
  void changekitab() {
    setState(() {
      kitab = !kitab;
    });
  }

  void changebookmark() {
    setState(() {
      bookmark = !bookmark;
    });
  }

  void changetrakhir() {
    setState(() {
      trakhirbaca = !trakhirbaca;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kitab Hadist'),
      ),
      backgroundColor: Color(0xffFFF8E2),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(27.0, 37.0, 27.0, 37.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      'Cari Tema Hadist',
                      style: TextStyle(fontSize: 14),
                    )),
                    Icon(
                      FontAwesomeIcons.search,
                      size: 15,
                    ),
                  ],
                ),
                SizedBox(
                  height: 13,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Divider(
                      thickness: 2,
                      color: Color(0xffE1CEB1),
                    )),
                  ],
                ),
                SizedBox(
                  height: 22,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: <Widget>[
                    //     Expanded(
                    //       child: InkWell(
                    //         onTap: () {
                    //           changetrakhir();
                    //         },
                    //         child: AnimatedContainer(
                    //           duration: Duration(milliseconds: 250),
                    //           child: Container(
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.only(
                    //                   topLeft: Radius.circular(15.0),
                    //                   topRight: Radius.circular(15.0),
                    //                 ),
                    //                 color: trakhirbaca
                    //                     ? Color(0xffF4E9D0)
                    //                     : Color(0xffF5E6C9),
                    //               ),
                    //               height: 67,
                    //               child: Padding(
                    //                 padding: const EdgeInsets.fromLTRB(
                    //                     40.0, 24.0, 0.0, 0.0),
                    //                 child: Text(
                    //                   'Trakhir Baca',
                    //                   style: TextStyle(
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.bold),
                    //                 ),
                    //               )),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // ExpandedSection(
                    //   expand: trakhirbaca,
                    //   child: Container(
                    //     width: double.infinity,
                    //     color: Colors.red,
                    //     padding: EdgeInsets.all(25.0),
                    //     child: Text('Hello there'),
                    //   ),
                    // ),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: <Widget>[
                    //     Expanded(
                    //       child: InkWell(
                    //         onTap: () {
                    //           changebookmark();
                    //         },
                    //         child: AnimatedContainer(
                    //           duration: Duration(milliseconds: 250),
                    //           child: Container(
                    //               height: 67,
                    //               color: bookmark
                    //                   ? Color(0xffF4E9D0)
                    //                   : Color(0xffF5E6C9),
                    //               child: Padding(
                    //                 padding: const EdgeInsets.fromLTRB(
                    //                     40.0, 24.0, 0.0, 0.0),
                    //                 child: Text(
                    //                   'Bookmark',
                    //                   style: TextStyle(
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.bold),
                    //                 ),
                    //               )),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // ExpandedSection(
                    //   expand: bookmark,
                    //   child: Container(
                    //     width: double.infinity,
                    //     color: Colors.red,
                    //     padding: EdgeInsets.all(25.0),
                    //     child: Text('Hello there'),
                    //   ),
                    // ),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: <Widget>[
                    //     Expanded(
                    //       child: InkWell(
                    //         onTap: () {
                    //           changekitab();
                    //         },
                    //         child: AnimatedContainer(
                    //           duration: Duration(milliseconds: 250),
                    //           child: Container(
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.only(
                    //                   bottomLeft: kitab
                    //                       ? Radius.circular(0.0)
                    //                       : Radius.circular(15.0),
                    //                   bottomRight: kitab
                    //                       ? Radius.circular(0.0)
                    //                       : Radius.circular(15.0),
                    //                 ),
                    //                 color: kitab
                    //                     ? Color(0xffF4E9D0)
                    //                     : Color(0xffF5E6C9),
                    //               ),
                    //               height: 67,
                    //               child: Padding(
                    //                 padding: const EdgeInsets.fromLTRB(
                    //                     40.0, 24.0, 0.0, 0.0),
                    //                 child: Text(
                    //                   'Kumpulan Kitab Hadist',
                    //                   style: TextStyle(
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.bold),
                    //                 ),
                    //               )),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // ExpandedSection(
                    //   expand: kitab,
                    //   child: Container(
                    //     width: double.infinity,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.only(
                    //         bottomLeft: Radius.circular(15.0),
                    //         bottomRight: Radius.circular(15.0),
                    //       ),
                    //       color: Color(0xffF4E9D0),
                    //     ),
                    //     padding: EdgeInsets.all(15.0),
                    //     child: Column(
                    //       children: <Widget>[
                    //         GridView.count(
                    //           shrinkWrap: true,
                    //           physics: NeverScrollableScrollPhysics(),
                    //           crossAxisCount: 2,
                    //           childAspectRatio:
                    //               (MediaQuery.of(context).size.height / 800),
                    //           children:
                    //               List.generate(listHadist.length, (index) {
                    //             return Column(
                    //               children: <Widget>[
                    //                 Container(
                    //                   decoration: BoxDecoration(
                    //                     boxShadow: [
                    //                       BoxShadow(
                    //                         color: Colors.grey[400],
                    //                         blurRadius: 11.0,
                    //                       )
                    //                     ],
                    //                     color: Color(0xffE5E5E5),
                    //                     borderRadius: BorderRadius.only(
                    //                       topRight: Radius.circular(40.0),
                    //                       topLeft: Radius.circular(10.0),
                    //                       bottomLeft: Radius.circular(40.0),
                    //                       bottomRight: Radius.circular(10.0),
                    //                     ),
                    //                   ),
                    //                   height: 150.0,
                    //                   width: 110.0,
                    //                   child: Column(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.center,
                    //                     children: <Widget>[
                    //                       Text(
                    //                         '${listHadist[index]["judul"].toString()[0]}',
                    //                         style: TextStyle(
                    //                           fontSize: 55,
                    //                           fontWeight: FontWeight.bold,
                    //                         ),
                    //                       ),
                    //                       Text(
                    //                         '${listHadist[index]["judul"]}',
                    //                         style: TextStyle(
                    //                           fontSize: 14,
                    //                           fontWeight: FontWeight.normal,
                    //                         ),
                    //                       ),
                    //                       Text(
                    //                         '${listHadist[index]["total"]} Hadist',
                    //                         style: TextStyle(
                    //                           fontSize: 14,
                    //                           fontWeight: FontWeight.normal,
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ],
                    //             );
                    //           }),
                    //         ),
                    //         Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.end,
                    //             children: <Widget>[
                    //               Text(
                    //                 'Lihat Semua Kitab >',
                    //                 style: TextStyle(fontSize: 14),
                    //               ),
                    //             ],
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                        ),
                        color:
                            trakhirbaca ? Color(0xffF4E9D0) : Color(0xffF5E6C9),
                      ),
                      child: ExpansionTile(
                        onExpansionChanged: (bool hasil) {
                          setState(() {
                            changetrakhir();
                          });
                        },
                        title: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Trakhir Baca',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        initiallyExpanded: trakhirbaca,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text(
                              'Kamu belum baca Hadist di sini nih',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              print('baca di klik');
                            },
                            child: Container(
                              child: Text(
                                'Baca Yuk !',
                                style: TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: 300,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  child: Stack(
                                    children: <Widget>[
                                      Image.asset(
                                          'assets/images/Ellipse 11.png'),
                                      Positioned(
                                        top: 7,
                                        left: 14,
                                        child: Text(
                                          'B',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Bukhari - 52',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Semua perbuatan tergantung niatnya dan (balasan) bagi tiap- tiap orang(tergantung) apa yang menjadi hadiah bagi semua orang yang ingin di lakukan oelh semua orang bahkan presiden juga mengininkannya dengan makanan yang lezt dalweqp perlengkapawena warga neraga',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: bookmark ? Color(0xffF4E9D0) : Color(0xffF5E6C9),
                      child: ExpansionTile(
                        onExpansionChanged: (bool hasil) {
                          setState(() {
                            changebookmark();
                          });
                        },
                        title: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Bookmark',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        initiallyExpanded: bookmark,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text(
                              'Kamu belum tandai Hadist apapun',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              print('baca di klik');
                            },
                            child: Container(
                              child: Text(
                                'Baca Yuk !',
                                style: TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: 300,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  child: Stack(
                                    children: <Widget>[
                                      Image.asset(
                                          'assets/images/bookmark_24px.png'),
                                      Positioned(
                                        top: 4,
                                        left: 9,
                                        child: Text(
                                          'B',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Bukhari - 52',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            '1 minggu lalu',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Semua perbuatan tergantung niatnya dan (balasan) bagi tiap- tiap orang(tergantung) apa yang menjadi hadiah bagi semua orang yang ingin di lakukan oelh semua orang bahkan presiden juga mengininkannya dengan makanan yang lezt dalweqp perlengkapawena warga neraga',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          //devider
                          Container(
                            width: 300,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 0.0, 0.0, 0.0),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            width: 300,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  child: Stack(
                                    children: <Widget>[
                                      Image.asset(
                                          'assets/images/bookmark_24px.png'),
                                      Positioned(
                                        top: 4,
                                        left: 9,
                                        child: Text(
                                          'B',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Bukhari - 52',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            '1 minggu lalu',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Semua perbuatan tergantung niatnya dan (balasan) bagi tiap- tiap orang(tergantung) apa yang menjadi hadiah bagi semua orang yang ingin di lakukan oelh semua orang bahkan presiden juga mengininkannya dengan makanan yang lezt dalweqp perlengkapawena warga neraga',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        ),
                        color: kitab ? Color(0xffF4E9D0) : Color(0xffF5E6C9),
                      ),
                      child: ExpansionTile(
                        onExpansionChanged: (bool hasil) {
                          setState(() {
                            changekitab();
                          });
                        },
                        title: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Kumpulan Kitab Hadist',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        initiallyExpanded: kitab,
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  GridView.count(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    crossAxisCount: 2,
                                    childAspectRatio:
                                        (MediaQuery.of(context).size.height /
                                            800),
                                    children: List.generate(listHadist.length,
                                        (index) {
                                      return Column(
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ListKitab()),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey[400],
                                                    blurRadius: 11.0,
                                                  )
                                                ],
                                                color: Color(0xffE5E5E5),
                                                borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(40.0),
                                                  topLeft:
                                                      Radius.circular(10.0),
                                                  bottomLeft:
                                                      Radius.circular(40.0),
                                                  bottomRight:
                                                      Radius.circular(10.0),
                                                ),
                                              ),
                                              height: 150.0,
                                              width: 110.0,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    '${listHadist[index]["judul"].toString()[0]}',
                                                    style: TextStyle(
                                                      fontSize: 55,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${listHadist[index]["judul"]}',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${listHadist[index]["total"]} Hadist',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          'Lihat Semua Kitab >',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExpandedSection extends StatefulWidget {
  final Widget child;
  final bool expand;
  ExpandedSection({this.expand: false, this.child});

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection>
    with SingleTickerProviderStateMixin {
  AnimationController expandController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    Animation curve = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axisAlignment: 1.0, sizeFactor: animation, child: widget.child);
  }
}
