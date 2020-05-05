import 'package:appsmuslim/helpers/shimmer_helpers.dart';
import 'package:appsmuslim/pages/komik/isikomik.dart';
import 'package:appsmuslim/pages/komik/provider/providerKomik.dart';
import 'package:appsmuslim/pages/login/provider/loginProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListKomik extends StatefulWidget {
  @override
  _ListKomikState createState() => _ListKomikState();
}

class _ListKomikState extends State<ListKomik> {
  ScrollController scrollController = ScrollController();

  var listkomik = [
    {
      "No": "1",
      "Judul": "Episode 1",
      "Open": true,
      "linkimg":
          "https://nos.wjv-1.neo.id/cloudmax1-152/fp/65/ud/s6/45/bs/3c/de/vg/ci/5t/qg/bq/_s/2",
      "kata1": "Jangan timbun Masker!",
      "kata3": "(HR. Muslim no. 1605)",
      "kata2":
          '''Nabi shallallahu alaihi wa sallam bersabda, Tidak boleh menimbun barang, jika tidak, maka ia termasuk orang yang berdosa. '''
    },
    {
      "No": "2",
      "Judul": "Episode 2",
      "Open": true,
      "linkimg":
          "https://nos.wjv-1.neo.id/cloudmax1-152/ho/zi/nq/3k/mr/ef/lo/ym/ak/he/oc/dt/ua/_s/2",
      "kata1":
          "Menjaga kebersihan agar terhindar dari Virus Corona dan selalu berdoa:",
      "kata3": "(HR. Muslim no. 2739)",
      "kata2":
          '''Dari Abdullah bin Umar, dia berkata, Di antara doa Rasulullah shallallahu alaihi wa sallam adalah: ALLOOHUMMA INNII AUUDZU BIKA MIN ZAWAALI NIMATIK, WA TAHAWWULI AAFIYATIK, WA FUJAA ATI NIQMATIK, WA JAMII I SAKHOTHIK (Ya Allah, sesungguhnya aku berlindung kepada-Mu dari hilangnya kenikmatan yang telah Engkau berikan, dari berubahnya kesehatan yang telah Engkau anugerahkan, dari siksa-Mu yang datang secara tiba-tiba, dan dari segala kemurkaan-Mu). '''
    },
    {
      "No": "3",
      "Judul": "Episode 3",
      "Open": true,
      "linkimg":
          "https://nos.wjv-1.neo.id/cloudmax1-152/7j/ld/4p/uk/rj/hg/vf/rq/us/io/r3/ex/xm/_s/2",
      "kata1":
          "Belanjalah sesuai dengan apa yang dibutuhkan, ingatlah, ada orang lain yang mungkin sangat membutuhkan, namun terhalang dikarenakan keserakahan diri kita:",
      "kata3": "(HR. Bukhari no. 6951 dan Muslim no. 2580)",
      "kata2":
          '''Dari Ibnu Umar, Nabi shallallahu alaihi wa sallam bersabda, Siapa yang biasa membantu hajat saudaranya, maka Allah akan senantiasa menolongnya dalam hajatnya. '''
    },
    {
      "No": "4",
      "Judul": "Episode 4",
      "Open": true,
      "linkimg":
          "https://nos.wjv-1.neo.id/cloudmax1-152/gn/oj/vr/d6/oz/d2/nc/ke/yb/d3/ie/rs/ha/_s/2",
      "kata1": "Konsumsi Buah Kurma Sebagai Upaya Pencegahan Terkena Racun:",
      "kata3": "(HR. Bukhari no. 5779 dan Muslim no. 2047)",
      "kata2":
          '''Barangsiapa di pagi hari memakan tujuh butir kurma ajwa, maka ia tidak akan terkena racun dan sihir pada hari itu. '''
    },
    {
      "No": "5",
      "Judul": "Episode 5",
      "Open": true,
      "linkimg":
          "https://nos.wjv-1.neo.id/cloudmax1-152/ql/mk/gm/us/uj/ax/td/ct/y6/y5/wq/jp/zi/_s/2",
      "kata1": "Anjuran meminum Madu untuk menyembuhkan segala penyakit :",
      "kata3": "(QS. An-Nahl :68,69)",
      "kata2":
          '''Dan Rabbmu mewahyukan kepada lebah, buatlah sarang-sarang di bukit-bukit, di pohon-pohon kayu, dan di tempat-tempat yang dibikin manusia. Kemudian makanlah dari tiap-tiap (macam) buah-buahan dan tempuhlah jalan Rabbmu yang telah dimudahkan (bagimu). Dari perut lebah itu keluar minuman (madu) yang bermacam-macam warnanya, di dalamnya terdapat obat yang menyembuhkan bagi manusia. Sesungguhnya pada yang demikian itu benar-benar terdapat tanda (kebesaran Rabb) bagi orang-orang yang memikirkan.  '''
    },
    {
      "No": "6",
      "Judul": "Episode 6",
      "Open": true,
      "linkimg":
          "https://nos.wjv-1.neo.id/cloudmax1-152/kn/sl/ni/3g/xz/gk/jj/ab/du/i5/6a/fw/ku/_s/2",
      "kata1": "Allah sudah menjamin akan ada kemudahan setelah kesulitan:",
      "kata3": "(QS. An Nasyr: 5-6)",
      "kata2":
          '''Karena sesungguhnya sesudah kesulitan itu ada kemudahan. Sesungguhnya sesudah kesulitan itu ada kemudahan. '''
    },
    {
      "No": "7",
      "Judul": "Episode 7",
      "Open": true,
      "linkimg":
          "https://nos.wjv-1.neo.id/cloudmax1-152/et/bn/uf/kh/if/an/vn/eu/iy/ql/6t/4r/b4/_s/2",
      "kata1":
          "Jagalah diri kita agar terhindar dari penularan Virus Corona, dan patuhilah aturan untuk Pencegahan Penularan Virus seperti Cuci Tangan dan Memakai Masker:",
      "kata3": "(HR. Bukhari, no. 2955)",
      "kata2":
          '''Patuh dan taat pada pemimpin tetap ada selama bukan dalam maksiat. Jika diperintah dalam maksiat, maka tidak ada kepatuhan dan ketaatan. '''
    },
    {
      "No": "8",
      "Judul": "Episode 8",
      "Open": true,
      "linkimg":
          "https://nos.wjv-1.neo.id/cloudmax1-152/lp/ox/iv/ln/6v/gg/lp/3w/7v/ek/kc/4r/by/_s/2",
      "kata1":
          "Anjuran mengkonsumsi Habbatu Ssauda untuk menyembukan segala macam penyakit kecuali kematian :",
      "kata3": "(HR. Bukhari & Muslim)",
      "kata2":
          '''Sesungguhnya pada habbatu ssauda terdapat obat untuk segala macam penyakit, kecuali kematian. '''
    },
    {
      "No": "9",
      "Judul": "Episode 9",
      "Open": true,
      "linkimg":
          "https://nos.wjv-1.neo.id/cloudmax1-152/c2/56/ui/4d/mr/hq/3c/kk/ed/o7/ae/xf/se/_s/2",
      "kata1":
          "Mumpung Lagi Di Rumah Aja, Yuk Pelajari Al-Quran dan Menghafalnya Biar Gak Lupa!",
      "kata3": "(HR. Bukhari, Kitab: Keutamaan-keutamaan Al-Quran (66))",
      "kata2":
          '''Aisyah radhiyallahu anha berkata, Nabi shallallahu alaihi wasallam pernah mendengarkan bacaan (al-Quran) seorang lelaki di dalam masjid. Kemudian Beliau Shallallahu alaihi wa sallam bersabda: Semoga Allah merahmatinya. Sungguh, ia telah mengingatkanku satu ayat yang sebelumnya aku dilupakan (untuk mengingat)nya.'''
    },
    {
      "No": "10",
      "Judul": "Episode 10",
      "Open": true,
      "linkimg":
          "https://nos.wjv-1.neo.id/cloudmax1-152/m7/wh/ou/2p/tn/ap/hj/zt/mf/vl/xl/44/jm/_s/2",
      "kata1":
          "Banyak Hoax Tentang Wabah Corona, Jadi Gunakanlah Gadget Seperlunya ya Sob:",
      "kata3": "(Tirmidzi, no. 2317;Ibnu Majah, no. 3976)",
      "kata2":
          '''Rasulullah shallallahu alaihi wa sallam bersabda, Di antara kebaikan islam seseorang adalah meninggalkan hal yang tidak bermanfaat. '''
    },
  ];

  @override
  void initState() {
    //getData();
    super.initState();
  }

  getData() async {
    await Provider.of<KomikProvider>(context, listen: false).getData();
    await Provider.of<LoginProvider>(context, listen: false).getData();

    final loginData = Provider.of<LoginProvider>(context).dataUsers;
    await Provider.of<KomikProvider>(context, listen: false)
        .setStatus(loginData[0].subscribe.komik);
  }

  @override
  Widget build(BuildContext context) {
    // final KomikProvider komikData = Provider.of<KomikProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("List Komik"),
      ),
      backgroundColor: Color(0xffF0F0F0),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
        child: Container(
          child: GridView.count(
            controller: scrollController,
            crossAxisCount: 3,
            childAspectRatio: (MediaQuery.of(context).size.height / 1100),
            children: List.generate(listkomik.length, (index) {
              return InkWell(
                onTap: () {
                  if (index != 9) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IsiKomik(
                                data: listkomik[index],
                                data2: listkomik[index + 1],
                              )),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IsiKomik(
                                data: listkomik[index],
                                data2: listkomik[index],
                              )),
                    );
                  }
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[400],
                            blurRadius: 11.0,
                          )
                        ],
                        color:
                            listkomik[index]['Open'] ? Colors.grey : Colors.red,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                      ),
                      height: 110.0,
                      width: 110.0,
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(40.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                          child: Image.asset('assets/images/thumbkecil.png')),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      width: 110,
                      child: Text(
                        "Ep. ${listkomik[index]['No']}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      width: 110,
                      child: Text(
                        "${listkomik[index]['Judul']}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

Widget komikListShimmer() {
  return ShimmerHelpers.createShimmer(
    child: InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              height: 110.0,
              width: 110.0,
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              height: 20,
              width: 50,
              color: Colors.white,
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              height: 20,
              width: 100,
              color: Colors.white,
            ),
          ],
        ),
      ),
    ),
  );
}
