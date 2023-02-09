// To parse this JSON data, do
//
//     final desaModels = desaModelsFromJson(jsonString);

import 'dart:convert';

DesaModels desaModelsFromJson(String str) =>
    DesaModels.fromJson(json.decode(str));

String desaModelsToJson(DesaModels data) => json.encode(data.toJson());

class DesaModels {
  DesaModels({
    this.noKel,
    this.namaKel,
    this.noKec,
    this.noKab,
    this.noProp,
  });

  String? noKel;
  String? namaKel;
  String? noKec;
  String? noKab;
  String? noProp;

  factory DesaModels.fromJson(Map<String, dynamic> json) => DesaModels(
        noKel: json["NO_KEL"],
        namaKel: json["NAMA_KEL"],
        noKec: json["NO_KEC"],
        noKab: json["NO_KAB"],
        noProp: json["NO_PROP"],
      );

  Map<String, dynamic> toJson() => {
        "NO_KEL": noKel,
        "NAMA_KEL": namaKel,
        "NO_KEC": noKec,
        "NO_KAB": noKab,
        "NO_PROP": noProp,
      };
}
