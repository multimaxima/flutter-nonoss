// To parse this JSON data, do
//
//     final kategoriKkpr = kategoriKkprFromJson(jsonString);

import 'dart:convert';

KategoriKkpr? kategoriKkprFromJson(String str) =>
    KategoriKkpr.fromJson(json.decode(str));

String kategoriKkprToJson(KategoriKkpr? data) => json.encode(data!.toJson());

class KategoriKkpr {
  KategoriKkpr({
    this.id,
    this.kategori,
    this.perorangan,
    this.perusahaan,
    this.yayasan,
    this.pemerintah,
  });

  int? id;
  String? kategori;
  int? perorangan;
  int? perusahaan;
  int? yayasan;
  int? pemerintah;

  factory KategoriKkpr.fromJson(Map<String, dynamic> json) => KategoriKkpr(
        id: json["id"],
        kategori: json["kategori"],
        perorangan: json["perorangan"],
        perusahaan: json["perusahaan"],
        yayasan: json["yayasan"],
        pemerintah: json["pemerintah"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kategori": kategori,
        "perorangan": perorangan,
        "perusahaan": perusahaan,
        "yayasan": yayasan,
        "pemerintah": pemerintah,
      };
}
