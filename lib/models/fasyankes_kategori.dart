// To parse this JSON data, do
//
//     final fasyankesKategoriModels = fasyankesKategoriModelsFromJson(jsonString);

import 'dart:convert';

FasyankesKategoriModels fasyankesKategoriModelsFromJson(String str) =>
    FasyankesKategoriModels.fromJson(json.decode(str));

String fasyankesKategoriModelsToJson(FasyankesKategoriModels data) =>
    json.encode(data.toJson());

class FasyankesKategoriModels {
  FasyankesKategoriModels({
    this.id,
    this.jenis,
    this.kategori,
    this.createdAt,
    this.updatedAt,
    this.petugasCreate,
    this.petugasUpdate,
  });

  int? id;
  String? jenis;
  String? kategori;
  DateTime? createdAt;
  DateTime? updatedAt;
  BigInt? petugasCreate;
  BigInt? petugasUpdate;

  factory FasyankesKategoriModels.fromJson(Map<String, dynamic> json) =>
      FasyankesKategoriModels(
        id: json["id"],
        jenis: json["jenis"],
        kategori: json["kategori"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        petugasCreate: json["petugas_create"],
        petugasUpdate: json["petugas_update"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jenis": jenis,
        "kategori": kategori,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "petugas_create": petugasCreate,
        "petugas_update": petugasUpdate,
      };
}
