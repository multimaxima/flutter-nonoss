// To parse this JSON data, do
//
//     final kecamatanModels = kecamatanModelsFromJson(jsonString);

import 'dart:convert';

KecamatanModels kecamatanModelsFromJson(String str) =>
    KecamatanModels.fromJson(json.decode(str));

String kecamatanModelsToJson(KecamatanModels data) =>
    json.encode(data.toJson());

class KecamatanModels {
  KecamatanModels({
    this.noKec,
    this.namaKec,
    this.noKab,
    this.noProp,
  });

  String? noKec;
  String? namaKec;
  String? noKab;
  String? noProp;

  factory KecamatanModels.fromJson(Map<String, dynamic> json) =>
      KecamatanModels(
        noKec: json["NO_KEC"],
        namaKec: json["NAMA_KEC"],
        noKab: json["NO_KAB"],
        noProp: json["NO_PROP"],
      );

  Map<String, dynamic> toJson() => {
        "NO_KEC": noKec,
        "NAMA_KEC": namaKec,
        "NO_KAB": noKab,
        "NO_PROP": noProp,
      };
}
