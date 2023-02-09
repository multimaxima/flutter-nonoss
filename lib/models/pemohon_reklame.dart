// To parse this JSON data, do
//
//     final pemohonReklameModels = pemohonReklameModelsFromJson(jsonString);

import 'dart:convert';

PemohonReklameModels pemohonReklameModelsFromJson(String str) =>
    PemohonReklameModels.fromJson(json.decode(str));

String pemohonReklameModelsToJson(PemohonReklameModels data) =>
    json.encode(data.toJson());

class PemohonReklameModels {
  PemohonReklameModels({
    this.id,
    this.jenis,
    this.nib,
    this.npwp,
    this.npwpd,
    this.skPenunjukan,
    this.aktif,
  });

  int? id;
  String? jenis;
  int? nib;
  int? npwp;
  int? npwpd;
  int? skPenunjukan;
  int? aktif;

  factory PemohonReklameModels.fromJson(Map<String, dynamic> json) =>
      PemohonReklameModels(
        id: json["id"],
        jenis: json["jenis"],
        nib: json["nib"],
        npwp: json["npwp"],
        npwpd: json["npwpd"],
        skPenunjukan: json["sk_penunjukan"],
        aktif: json["aktif"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jenis": jenis,
        "nib": nib,
        "npwp": npwp,
        "npwpd": npwpd,
        "sk_penunjukan": skPenunjukan,
        "aktif": aktif,
      };
}
