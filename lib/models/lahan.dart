// To parse this JSON data, do
//
//     final lahanModels = lahanModelsFromJson(jsonString);

import 'dart:convert';

LahanModels lahanModelsFromJson(String str) =>
    LahanModels.fromJson(json.decode(str));

String lahanModelsToJson(LahanModels data) => json.encode(data.toJson());

class LahanModels {
  LahanModels({
    this.id,
    this.lahan,
    this.hapus,
  });

  int? id;
  String? lahan;
  int? hapus;

  factory LahanModels.fromJson(Map<String, dynamic> json) => LahanModels(
        id: json["id"],
        lahan: json["lahan"],
        hapus: json["hapus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lahan": lahan,
        "hapus": hapus,
      };
}
