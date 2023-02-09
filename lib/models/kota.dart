// To parse this JSON data, do
//
//     final kotaModels = kotaModelsFromJson(jsonString);

import 'dart:convert';

KotaModels kotaModelsFromJson(String str) =>
    KotaModels.fromJson(json.decode(str));

String kotaModelsToJson(KotaModels data) => json.encode(data.toJson());

class KotaModels {
  KotaModels({
    this.noKab,
    this.namaKab,
    this.noProp,
  });

  String? noKab;
  String? namaKab;
  String? noProp;

  factory KotaModels.fromJson(Map<String, dynamic> json) => KotaModels(
        noKab: json["NO_KAB"],
        namaKab: json["NAMA_KAB"],
        noProp: json["NO_PROP"],
      );

  Map<String, dynamic> toJson() => {
        "NO_KAB": noKab,
        "NAMA_KAB": namaKab,
        "NO_PROP": noProp,
      };
}
