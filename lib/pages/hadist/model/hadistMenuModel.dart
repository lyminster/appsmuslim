

class HadistMenu {
  bool isExpanded;
  String judul;

  HadistMenu({this.isExpanded, this.judul});
}

class ListKitabData {
  int id;
  String nama;

  ListKitabData({this.id,this.nama});

  factory ListKitabData.fromJson(Map<String, dynamic> json) => new ListKitabData(
        id: json['id'],
        nama: json["nama"]
      );

}

class ListBabData {
  int id;
  int idkitab;
  String nama;

  ListBabData({this.id,this.idkitab,this.nama});

  factory ListBabData.fromJson(Map<String, dynamic> json) => new ListBabData(
        id: json['id'],
        idkitab: json['id_kitab'],
        nama: json["nama"]
      );

}

class ListHadistData {
  int id;
  int idbab;
  String isi;

  ListHadistData({this.id,this.idbab,this.isi});

  factory ListHadistData.fromJson(Map<String, dynamic> json) => new ListHadistData(
        id: json['id'],
        idbab: json['id_bab'],
        isi: json["isi"]
      );

}