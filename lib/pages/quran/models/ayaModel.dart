import 'package:appsmuslim/pages/quran/models/bookmarksModel.dart';

class Aya {
  String ayaIndex;
  String sura;
  String aya;
  String text;
  String indoText;
  String readText;
  String bismillah;
  int juz;
  
  BookmarksModel bookmarksModel;
  bool isBookmarked;

  Aya({
    this.ayaIndex,
    this.sura,
    this.aya,
    this.text,
    this.indoText,
    this.readText,
    this.bismillah,
    this.juz
  });

  factory Aya.fromJson(Map<String, dynamic> json) => new Aya(
        ayaIndex:json['id'].toString(),
        sura: json["suraId"].toString(),
        aya: json["verseID"].toString() ?? json['id'].toString(),
        text: json["ayahText"],
        indoText: json['indoText'],
        readText: json['readText'],
        bismillah: json["verseID"] == 1 && json["suraId"] != 1 ? 'Ada' : null,
        juz:json["juz"]
      );

  Map<String, dynamic> toJson() => {
        "aya": aya,
        "text": text,
        "bismillah": bismillah == null ? null : bismillah,
        "juz":juz
      };
}