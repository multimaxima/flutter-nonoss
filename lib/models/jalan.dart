// To parse this JSON data, do
//
//     final jalanModels = jalanModelsFromJson(jsonString);

import 'dart:convert';

JalanModels jalanModelsFromJson(String str) =>
    JalanModels.fromJson(json.decode(str));

String jalanModelsToJson(JalanModels data) => json.encode(data.toJson());

class JalanModels {
  JalanModels({
    this.id,
    this.nama,
    this.noKec,
    this.noKel,
    this.kecamatan,
    this.desa,
    this.zona,
    this.poligon,
    this.hapus,
  });

  int? id;
  String? nama;
  String? noKec;
  String? noKel;
  String? kecamatan;
  String? desa;
  String? zona;
  String? poligon;
  int? hapus;

  factory JalanModels.fromJson(Map<String, dynamic> json) => JalanModels(
        id: json["id"],
        nama: json["nama"],
        noKec: json["NO_KEC"],
        noKel: json["NO_KEL"],
        kecamatan: json["kecamatan"],
        desa: json["desa"],
        zona: json["zona"],
        poligon: json["poligon"],
        hapus: json["hapus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "NO_KEC": noKec,
        "NO_KEL": noKel,
        "kecamatan": kecamatan,
        "desa": desa,
        "zona": zona,
        "poligon": poligon,
        "hapus": hapus,
      };
}
