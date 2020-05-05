class Komik{
  String komikChapter;
  String urlThumnail;
  String urlKomik;
  String judulKomik;
  bool statusKomik;

  Komik({
    this.komikChapter,
    this.urlThumnail,
    this.urlKomik,
    this.judulKomik,
    this.statusKomik
  });

    factory Komik.fromJson(Map<String, dynamic> json) => new Komik(
        komikChapter:json['komikChapter'],
        urlThumnail: json["urlThumnail"],
        urlKomik: json["urlKomik"],
        judulKomik: json["judulKomik"],
        statusKomik: json['statusKomik'],
    );
    
}