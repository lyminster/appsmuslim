import 'package:appsmuslim/pages/quran/provider/settingProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingQuran extends StatefulWidget {
  @override
  _SettingQuranState createState() => _SettingQuranState();
}

class _SettingQuranState extends State<SettingQuran> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: Container(
        height: 220,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).dialogBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Text(
                'Font Size',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // Arabic font size
            SizedBox.fromSize(size: Size.fromHeight(10)),
            Container(
              child: Text(
                'Arabic Text',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Consumer<SettingValues>(builder: (context, setting, _) {
              return Slider(
                min: 30,
                max: 76,
                value: setting.arabicText,
                activeColor: Theme.of(context).accentColor,
                inactiveColor: Theme.of(context).dividerColor,
                onChanged: (double value) async {
                  Provider.of<SettingValues>(context, listen: false)
                      .updateArabicText(value);
                },
              );
            }),
            // Translation font size
            SizedBox.fromSize(size: Size.fromHeight(5)),
            Container(
              child: Text(
                'Translation',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Consumer<SettingValues>(builder: (context, setting, _) {
              return Slider(
                min: 20,
                max: 45,
                value: setting.transText,
                activeColor: Theme.of(context).accentColor,
                inactiveColor: Theme.of(context).dividerColor,
                onChanged: (double value) async {
                  Provider.of<SettingValues>(context, listen: false)
                      .updatetransText(value);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
