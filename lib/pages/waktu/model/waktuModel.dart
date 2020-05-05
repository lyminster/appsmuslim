class DetailWaktu {
  String nama;
  String jam;
  bool solatStatus;
  bool notificationStatus;

  DetailWaktu(this.nama, this.jam, this.solatStatus, this.notificationStatus);
}

class WaktuNotification {
  int id;
  String namaSolat;

  WaktuNotification({this.id, this.namaSolat});

  factory WaktuNotification.fromJson(Map<String, dynamic> json) =>
      new WaktuNotification(
          id: json["id"],
          namaSolat: json["nama_solat"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "nama_solat": namaSolat};
}

class WaktuBulan {
  String tanggal;
  String imsak;
  String subuh;
  String dhuha;
  String dzuhur;
  String ashar;
  String maghrib;
  String isya;

  WaktuBulan(
    this.tanggal,
    this.imsak,
    this.subuh,
    this.dhuha,
    this.dzuhur,
    this.ashar,
    this.maghrib,
    this.isya,
  );
}
