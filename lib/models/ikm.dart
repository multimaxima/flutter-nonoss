// To parse this JSON data, do
//
//     final ikmModels = ikmModelsFromJson(jsonString);

import 'dart:convert';

IkmModels ikmModelsFromJson(String str) => IkmModels.fromJson(json.decode(str));

String ikmModelsToJson(IkmModels data) => json.encode(data.toJson());

class IkmModels {
  IkmModels({
    this.id,
    this.idPermohonan,
    this.pertanyaan,
    this.a,
    this.b,
    this.c,
    this.d,
    this.score,
  });

  int? id;
  int? idPermohonan;
  String? pertanyaan;
  String? a;
  String? b;
  String? c;
  String? d;
  String? score;

  factory IkmModels.fromJson(Map<String, dynamic> json) => IkmModels(
        id: json["id"],
        idPermohonan: json["id_permohonan"],
        pertanyaan: json["pertanyaan"],
        a: json["a"],
        b: json["b"],
        c: json["c"],
        d: json["d"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_permohonan": idPermohonan,
        "pertanyaan": pertanyaan,
        "a": a,
        "b": b,
        "c": c,
        "d": d,
        "score": score,
      };
}
