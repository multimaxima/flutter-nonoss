// To parse this JSON data, do
//
//     final negaraModels = negaraModelsFromJson(jsonString);

import 'dart:convert';

NegaraModels negaraModelsFromJson(String str) =>
    NegaraModels.fromJson(json.decode(str));

String negaraModelsToJson(NegaraModels data) => json.encode(data.toJson());

class NegaraModels {
  NegaraModels({
    this.noRef,
    this.kdNegara,
    this.namaNegara,
  });

  int? noRef;
  String? kdNegara;
  String? namaNegara;

  factory NegaraModels.fromJson(Map<String, dynamic> json) => NegaraModels(
        noRef: json["no_ref"],
        kdNegara: json["kd_negara"],
        namaNegara: json["nama_negara"],
      );

  Map<String, dynamic> toJson() => {
        "no_ref": noRef,
        "kd_negara": kdNegara,
        "nama_negara": namaNegara,
      };
}
