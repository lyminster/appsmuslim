import 'dart:convert';

class BookmarksModel {
  int id;
  int sura;
  String suraName;
  int aya;
  String jenis;
  String namaFolder;
  int juzNumber;
  DateTime insertTime;

  BookmarksModel({
    this.id,
    this.sura,
    this.suraName,
    this.aya,
    this.jenis,
    this.namaFolder,
    this.juzNumber,
    this.insertTime,
  });

  static BookmarksModel bookmarksModelFromJson(String str) {
    final jsonData = json.decode(str);
    return BookmarksModel.fromJson(jsonData);
  }

  static String bookmarksModelToJson(BookmarksModel data) {
    final dyn = data.toJson();
    return json.encode(dyn);
  }

  factory BookmarksModel.fromJson(Map<String, dynamic> json) =>
      new BookmarksModel(
        id: json["id"],
        sura: json["sura"],
        suraName: json["sura_name"],
        aya: json["aya"],
        jenis: json["jenis"],
        namaFolder: json["nama_folder"],
        juzNumber: json["juz_number"],
        insertTime: DateTime.tryParse(json["insert_time"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sura": sura,
        "sura_name": suraName,
        "aya": aya,
        "jenis": jenis,
        "nama_folder": namaFolder,
        "juz_number": juzNumber,
        "insert_time": insertTime.toIso8601String(),
      };
}

class BookmarkFolder {
  int id;
  String namaFolder;
  DateTime insertTime;

  BookmarkFolder({
    this.id,
    this.namaFolder,
    this.insertTime
  });

  static BookmarkFolder bookmarksModelFromJson(String str) {
    final jsonData = json.decode(str);
    return BookmarkFolder.fromJson(jsonData);
  }

  static String bookmarkFolderToJson(BookmarkFolder data) {
    final dyn = data.toJson();
    return json.encode(dyn);
  }

  factory BookmarkFolder.fromJson(Map<String, dynamic> json) =>
      new BookmarkFolder(
        id: json["id"],
        namaFolder: json["nama_folder"],
        insertTime: DateTime.tryParse(json["insert_time"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_folder": namaFolder,
        "insert_time": insertTime.toIso8601String(),
      };

}
