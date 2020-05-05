import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  bool _isHidePass = true;

  void _toblepass() {
    setState(() {
      _isHidePass = !_isHidePass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Akun Saya'),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.check),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      backgroundColor: Color(0xffFFF8E2),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(27, 0.0, 27, 0.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 32,
                ),
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
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
                    ))),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          labelText: 'Nama',
                          hintText: 'Nama',
                          labelStyle: TextStyle(
                            color: Color(0xff4D3010),
                            letterSpacing: 1.2,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a Nama';
                          }
                          // return null;
                        },
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          labelText: 'Email',
                          hintText: 'Email',
                          labelStyle: TextStyle(
                            color: Color(0xff4D3010),
                            letterSpacing: 1.2,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a Email';
                          }
                          // return null;
                        },
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          labelText: 'No Handphone',
                          hintText: 'No Handphone',
                          labelStyle: TextStyle(
                            color: Color(0xff4D3010),
                            letterSpacing: 1.2,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a No HandPhone';
                          }
                          // return null;
                        },
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        obscureText: _isHidePass,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _toblepass();
                            },
                            child: Icon(
                              _isHidePass
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color:
                                  _isHidePass ? Colors.grey : Color(0xff4D3010),
                            ),
                          ),
                          labelText: 'Kata Sandi',
                          hintText: 'Kata Sandi',
                          labelStyle: TextStyle(
                            color: Color(0xff4D3010),
                            letterSpacing: 1.2,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a Password';
                          }
                          // return null;
                        },
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        obscureText: _isHidePass,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _toblepass();
                            },
                            child: Icon(
                              _isHidePass
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color:
                                  _isHidePass ? Colors.grey : Color(0xff4D3010),
                            ),
                          ),
                          labelText: 'Ulangi Kata Sandi',
                          hintText: 'Ulangi Kata Sandi',
                          labelStyle: TextStyle(
                            color: Color(0xff4D3010),
                            letterSpacing: 1.2,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a Password';
                          }
                          // return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
