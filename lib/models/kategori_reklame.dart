// To parse this JSON data, do
//
//     final kategoriReklameModels = kategoriReklameModelsFromJson(jsonString);

import 'dart:convert';

KategoriReklameModels kategoriReklameModelsFromJson(String str) =>
    KategoriReklameModels.fromJson(json.decode(str));

String kategoriReklameModelsToJson(KategoriReklameModels data) =>
    json.encode(data.toJson());

class KategoriReklameModels {
  KategoriReklameModels({
    this.id,
    this.kategori,
    this.diskripsi,
    this.disclaimer,
    this.aktif,
  });

  int? id;
  String? kategori;
  String? diskripsi;
  String? disclaimer;
  int? aktif;

  factory KategoriReklameModels.fromJson(Map<String, dynamic> json) =>
      KategoriReklameModels(
        id: json["id"],
        kategori: json["kategori"],
        diskripsi: json["diskripsi"],
        disclaimer: json["disclaimer"],
        aktif: json["aktif"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kategori": kategori,
        "diskripsi": diskripsi,
        "disclaimer": disclaimer,
        "aktif": aktif,
      };
}
