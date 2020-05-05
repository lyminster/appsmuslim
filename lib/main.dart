import 'package:appsmuslim/pages/hadist/provider/hadistdata.dart';
import 'package:appsmuslim/pages/komik/provider/providerKomik.dart';
import 'package:appsmuslim/pages/login/provider/loginProvider.dart';
import 'package:appsmuslim/pages/menuUtama.dart';
import 'package:appsmuslim/pages/quran/provider/audioProvider.dart';
import 'package:appsmuslim/pages/quran/provider/ayaProvider.dart';
import 'package:appsmuslim/pages/quran/provider/bookmarkProvider.dart';
import 'package:appsmuslim/pages/quran/provider/juzProvider.dart';
import 'package:appsmuslim/pages/quran/provider/locationProvider.dart';
import 'package:appsmuslim/pages/quran/provider/settingProvider.dart';
import 'package:appsmuslim/pages/quran/provider/suraProvider.dart';
import 'package:appsmuslim/pages/waktu/provider/waktuProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListSuraData()),
        ChangeNotifierProvider(create: (_) => ListJuzData()),
        ChangeNotifierProvider(create: (_) => ListAyaData()),
        ChangeNotifierProvider(create: (_) => SettingValues()),
        ChangeNotifierProvider(create: (_) => AudioData()),
        ChangeNotifierProvider(create: (_) => BookmarkData()),
        ChangeNotifierProvider(create: (_) => KomikProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => WaktuProvider()),
        ChangeNotifierProvider(create: (_) => HadistDataProvider()),
        ChangeNotifierProvider(create: (_) => LocationData()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xffC11018),
          fontFamily: 'SFPro'
        ),
        home: MainMenu(),
      ),
    );
  }
}
