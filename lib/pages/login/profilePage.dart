import 'package:appsmuslim/pages/login/editpage.dart';
import 'package:appsmuslim/pages/login/loginPage.dart';
import 'package:appsmuslim/pages/login/provider/sign_in.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool apa = false;
  bool cara = false;

  gantiStatus(value) {
    setState(() {
      value = !value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Akun Saya'),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
        ),
        backgroundColor: Color(0xffF1F1F1),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 172,
                color: Color(0xffF5E6C9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: 108,
                        width: 108,
                        decoration: BoxDecoration(
                          color: Color(0xffE1CEB1),
                          borderRadius: BorderRadius.all(Radius.circular(90)),
                        ),
                        child: Center(
                            child: Text(
                          'AS',
                          style: TextStyle(
                              fontSize: 36, fontWeight: FontWeight.w600),
                        ))),
                    SizedBox(
                      width: 16,
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => EditProfile()),
                        // );
                        signOutGoogle();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(43.0, 0.0, 0.0, 0.0),
                child: Text(
                  'Bergabung Sejak',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
                ),
              ),
              Text(name),
              Text(email),
              Padding(
                padding: const EdgeInsets.fromLTRB(43.0, 0.0, 0.0, 0.0),
                child: Text(
                  '2 Februari 2020',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(31.0, 0.0, 31.0, 0.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Status',
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 11),
                        ),
                        Text(
                          'Belum Berlangganan Komik Islami',
                          style:
                              TextStyle(color: Color(0xffF83700), fontSize: 16),
                        ),
                        Container(
                          child: ExpansionTile(
                            onExpansionChanged: (bool hasil) {
                              gantiStatus(apa);
                            },
                            title: Text(
                              'Apa Keuntungan Berlangganan Komik Islami?',
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                            initiallyExpanded: apa,
                            children: <Widget>[Text('Ini utnuk apak?')],
                          ),
                        ),
                        Container(
                          child: ExpansionTile(
                            onExpansionChanged: (bool hasil) {
                              gantiStatus(apa);
                            },
                            title: Text(
                              'Cara Berlangganan Komik Islami',
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                            initiallyExpanded: apa,
                            children: <Widget>[Text('Ini utnuk apak?')],
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          color: Color(0xff4D3010),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Langganan Sekarang',
                              style: TextStyle(
                                  color: Color(0xffE9CB97), fontSize: 11),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(43.0, 0.0, 43.0, 0.0),
                child: Text(
                  'Kasih saran yuk untuk Muslim Plus untuk pengalaman kamu yang lebih baik lagi',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 30.0),
                child: Container(
                  height: 122,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffF5E6C9),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 15.0, 12.0, 0.0),
                          child: TextField(
                            style: TextStyle(fontSize: 12),
                            maxLines: 8,
                            decoration: InputDecoration.collapsed(
                                hintText: "Contoh: Saya Ada Saran..."),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {},
                            child: Text(
                              'Kirim',
                              style: TextStyle(
                                  color: Color(0xff4D3010),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
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
        ));
  }
}
