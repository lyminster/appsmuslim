import 'package:flutter/material.dart';

class Inpirasi extends StatefulWidget {
  @override
  _InpirasiState createState() => _InpirasiState();
}

class _InpirasiState extends State<Inpirasi> {
  var datainspirasi = [
    {
      "judul": "",
      "isi":
          "Apabila Ramadhan tiba, pintu surga dibuka, pintu neraka ditutup, dan setan pun dibelenggu.",
      "ending": "(HR. Bukhari no. 3277 dan Muslim no. 1079)"
    },
    {
      "judul": "",
      "isi":
          "Allah Ta’ala berfirman, “Wahai orang-orang yang beriman diwajibkan bagi kalian berpuasa sebagaimana diwajibkan pada orang-orang sebelum kalian agar kalian menjadi orang-orang yang bertakwa.”",
      "ending": "(QS. Al Baqarah: 183)"
    },
    {
      "judul": "",
      "isi":
          "Barangsiapa melakukan puasa satu hari di jalan Allah (dalam melakukan ketaatan pada Allah), maka Allah akan menjauhkannya dari neraka sejauh perjalanan 70 tahun.”",
      "ending": "(HR. Bukhari no. 2840)"
    },
    {
      "judul": "",
      "isi":
          "”Barangsiapa yang berpuasa di bulan Ramadhan karena iman dan mengharap pahala dari Allah maka dosanya di masa lalu akan diampuni”.",
      "ending": "(HR. Bukhari No. 38 dan Muslim no. 760)"
    },
    {
      "judul": "",
      "isi":
          "“Sesungguhnya telah ada pada (diri) Rasulullah itu suri teladan yang baik bagimu (yaitu) bagi orang yang mengharap (rahmat) Allah dan (kedatangan) hari kiamat dan dia banyak menyebut Allah.”",
      "ending": "(QS. Al Ahzab : 21)"
    },
    {
      "judul": "",
      "isi":
          "“Tiga orang yang do’anya tidak tertolak: orang yang berpuasa sampai ia berbuka, pemimpin yang adil, dan do’a orang yang dizholimi”.",
      "ending": "(HR. Ahmad 2: 305)"
    },
    {
      "judul": "",
      "isi":
          "“Surga memiliki delapan buah pintu. Di antara pintu tersebut ada yang dinamakan pintu Ar Rayyan yang hanya dimasuki oleh orang-orang yang berpuasa.“",
      "ending": "(HR. Bukhari no. 3257)"
    },
    {
      "judul": "",
      "isi":
          "“Barangsiapa melakukan qiyam Ramadhan karena iman dan mencari pahala, maka dosa-dosanya yang telah lalu akan diampuni”",
      "ending": "(HR. Bukhari, no. 37 dan Muslim, no. 759) "
    },
    {
      "judul": "",
      "isi":
          "Dari ‘Abdullah bin ‘Umar radhiyallahu ‘anhuma, ia berkata bahwa Rasulullah shallallahu ‘alaihi wa sallam biasa beri’tikaf di sepuluh hari terakhir dari bulan Ramadhan.",
      "ending": "(HR. Bukhari, no. 2025; Muslim, no. 1171)"
    },
    {
      "judul": "",
      "isi":
          "“Yang namanya kuat bukanlah dengan pandai bergelut. Yang disebut kuat adalah yang dapat menguasai dirinya ketika marah.”",
      "ending": "(HR. Bukhari no. 6114 dan Muslim no. 2609)"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: datainspirasi.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(35.0),
              child: Container(
                height: 220,
                width: 220,
                decoration: BoxDecoration(
                  color: Colors.red,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[500],
                      blurRadius: 21.0,
                    )
                  ],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(5)),
                  image: DecorationImage(
                    image: new AssetImage('assets/images/inspirasi.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(datainspirasi[index]["isi"]),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 30.0),
                      child: Container(
                        width: 100,
                        child: Text(datainspirasi[index]["ending"]),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
