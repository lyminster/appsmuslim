class Aya {
  String aya;
  String text;
  String bismillah;

  Aya({
    this.aya,
    this.text,
    this.bismillah,
  });

  factory Aya.fromJson(Map<String, dynamic> json) => new Aya(
        aya: json["aya"] ?? json['index'],
        text: json["text"],
        bismillah: json["bismillah"] == null ? null : json["bismillah"],
      );

  Map<String, dynamic> toJson() => {
        "aya": aya,
        "text": text,
        "bismillah": bismillah == null ? null : bismillah,
      };
}