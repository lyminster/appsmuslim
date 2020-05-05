import 'package:appsmuslim/pages/quran/provider/locationProvider.dart';
import 'package:appsmuslim/pages/quran/qibla_new.dart';
import 'package:appsmuslim/pages/waktu/provider/waktuProvider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BulanSolat extends StatefulWidget {
  @override
  _BulanSolatState createState() => _BulanSolatState();
}

class _BulanSolatState extends State<BulanSolat> {
  var listWaktu = [
    {
      "tanggal": "1",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "2",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "3",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "4",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "5",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "6",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "7",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "8",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "9",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "10",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "11",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "12",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "13",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "14",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "15",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "16",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "17",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "18",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "19",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "20",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "21",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "22",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "23",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "24",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "25",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "26",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "27",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "28",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "29",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "30",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
    {
      "tanggal": "31",
      "Shubuh": "15:30",
      "Dzuhur": "15:30",
      "Ashar": "15:30",
      "Maghrib": "15:30",
      "Isya": "15:30"
    },
  ];
  var now = new DateTime.now();
  String formattedDate = "";

  double sizeFont = 12;
  double sizeFontJudul = 15;
  double tinggirow = 20;

  void initState() {
    super.initState();
    getdata(DateTime.now());
    formattedDate = DateFormat('MMMM yyyy').format(now);
  }

  getdata(now) async {
    var pos = Provider.of<LocationData>(context,listen: false).position;
    if(pos == null){
      await Provider.of<WaktuProvider>(context, listen: false).getDataBulan(now, -6.173110, 106.829361);
    }
    else{
      await Provider.of<WaktuProvider>(context, listen: false).getDataBulan(now,pos.latitude,pos.longitude);
    }
    
    
  }

  addDate() {
    now = new DateTime(now.year, now.month + 1, now.day);
    getdata(now);
    setState(() {
      formattedDate = DateFormat('MMMM yyyy').format(now);
    });
  }

  substractDate() {
    now = new DateTime(now.year, now.month - 1, now.day);
    getdata(now);
    setState(() {
      formattedDate = DateFormat('MMMM yyyy').format(now);
    });
  }

  kurangifont() {
    setState(() {
      sizeFont = sizeFont - 2;
      sizeFontJudul = sizeFontJudul - 2;
      tinggirow = tinggirow - 3;
    });
  }

  tambahfont() {
    setState(() {
      sizeFont = sizeFont + 2;
      sizeFontJudul = sizeFontJudul + 2;
      tinggirow = tinggirow + 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    final WaktuProvider waktuData = Provider.of<WaktuProvider>(context);
    final LocationData locationData = Provider.of<LocationData>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Color(0xffC11018),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.compass),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuQibla()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Color(0xffE4131D),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                locationData.placemark != null
                    ? Text(
                        '${locationData.placemark[0].subAdministrativeArea} , ${locationData.placemark[0].subLocality}',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      )
                    : Text('Jakarta Indonesia',style: TextStyle(color: Colors.white),),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  FontAwesomeIcons.mapMarkerAlt,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    substractDate();
                  },
                  child: Icon(
                    FontAwesomeIcons.chevronLeft,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    addDate();
                  },
                  child: Icon(
                    FontAwesomeIcons.chevronRight,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                          onTap: () {
                            kurangifont();
                          },
                          child: Icon(
                            FontAwesomeIcons.searchMinus,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 30,
                      ),
                      InkWell(
                          onTap: () {
                            tambahfont();
                          },
                          child: Icon(
                            FontAwesomeIcons.searchPlus,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            waktuData.isGettingDataBulanan
                ? Text("Loading...")
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      color: Color(0xffC4C4C4),
                      child: DataTable(
                        columnSpacing: 5,
                        dataRowHeight: tinggirow,
                        horizontalMargin: 5,
                        columns: <DataColumn>[
                          DataColumn(
                            label: Text(
                              'Tanggal',
                              style: TextStyle(
                                  fontSize: sizeFontJudul, fontWeight: FontWeight.w500),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Imsak',
                              style: TextStyle(
                                  fontSize: sizeFontJudul, fontWeight: FontWeight.w500),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Shubuh',
                              style: TextStyle(
                                  fontSize: sizeFontJudul, fontWeight: FontWeight.w500),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Dhuha',
                              style: TextStyle(
                                  fontSize: sizeFontJudul, fontWeight: FontWeight.w500),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Dzuhur',
                              style: TextStyle(
                                  fontSize: sizeFontJudul, fontWeight: FontWeight.w500),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Ashar',
                              style: TextStyle(
                                  fontSize: sizeFontJudul, fontWeight: FontWeight.w500),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Maghrib',
                              style: TextStyle(
                                  fontSize: sizeFontJudul, fontWeight: FontWeight.w500),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Isya',
                              style: TextStyle(
                                  fontSize: sizeFontJudul, fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                        rows: waktuData.databulanan
                            .map((v) => DataRow(cells: [
                                  DataCell(
                                    Container(
                                      color: now.day.toString() == v.tanggal
                                          ? Color(0xffC11018)
                                          : null,
                                      child: Center(
                                        child: Text(
                                          v.tanggal,
                                          style: TextStyle(
                                            fontSize: sizeFont,
                                            color:
                                                now.day.toString() == v.tanggal
                                                    ? Colors.white
                                                    : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      color: now.day.toString() == v.tanggal
                                          ? Color(0xffC11018)
                                          : null,
                                      child: Center(
                                        child: Text(
                                          v.imsak,
                                          style: TextStyle(
                                            fontSize: sizeFont,
                                            color:
                                                now.day.toString() == v.tanggal
                                                    ? Colors.white
                                                    : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      color: now.day.toString() == v.tanggal
                                          ? Color(0xffC11018)
                                          : null,
                                      child: Center(
                                        child: Text(
                                          v.subuh,
                                          style: TextStyle(
                                            fontSize: sizeFont,
                                            color:
                                                now.day.toString() == v.tanggal
                                                    ? Colors.white
                                                    : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      color: now.day.toString() == v.tanggal
                                          ? Color(0xffC11018)
                                          : null,
                                      child: Center(
                                        child: Text(
                                          v.dhuha,
                                          style: TextStyle(
                                            fontSize: sizeFont,
                                            color:
                                                now.day.toString() == v.tanggal
                                                    ? Colors.white
                                                    : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      color: now.day.toString() == v.tanggal
                                          ? Color(0xffC11018)
                                          : null,
                                      child: Center(
                                        child: Text(
                                          v.dzuhur,
                                          style: TextStyle(
                                            fontSize: sizeFont,
                                            color:
                                                now.day.toString() == v.tanggal
                                                    ? Colors.white
                                                    : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      color: now.day.toString() == v.tanggal
                                          ? Color(0xffC11018)
                                          : null,
                                      child: Center(
                                        child: Text(
                                          v.ashar,
                                          style: TextStyle(
                                            fontSize: sizeFont,
                                            color:
                                                now.day.toString() == v.tanggal
                                                    ? Colors.white
                                                    : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      color: now.day.toString() == v.tanggal
                                          ? Color(0xffC11018)
                                          : null,
                                      child: Center(
                                        child: Text(
                                          v.maghrib,
                                          style: TextStyle(
                                            fontSize: sizeFont,
                                            color:
                                                now.day.toString() == v.tanggal
                                                    ? Colors.white
                                                    : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      color: now.day.toString() == v.tanggal
                                          ? Color(0xffC11018)
                                          : null,
                                      child: Center(
                                        child: Text(
                                          v.isya,
                                          style: TextStyle(
                                            fontSize: sizeFont,
                                            color:
                                                now.day.toString() == v.tanggal
                                                    ? Colors.white
                                                    : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]))
                            .toList(),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
