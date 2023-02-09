// To parse this JSON data, do
//
//     final pemohonKkprModels = pemohonKkprModelsFromJson(jsonString);

import 'dart:convert';

PemohonKkprModels pemohonKkprModelsFromJson(String str) =>
    PemohonKkprModels.fromJson(json.decode(str));

String pemohonKkprModelsToJson(PemohonKkprModels data) =>
    json.encode(data.toJson());

class PemohonKkprModels {
  PemohonKkprModels({
    this.id,
    this.jenis,
    this.nib,
    this.npwp,
    this.npwpd,
    this.aktif,
  });

  int? id;
  String? jenis;
  int? nib;
  int? npwp;
  int? npwpd;
  int? aktif;

  factory PemohonKkprModels.fromJson(Map<String, dynamic> json) =>
      PemohonKkprModels(
        id: json["id"],
        jenis: json["jenis"],
        nib: json["nib"],
        npwp: json["npwp"],
        npwpd: json["npwpd"],
        aktif: json["aktif"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jenis": jenis,
        "nib": nib,
        "npwp": npwp,
        "npwpd": npwpd,
        "aktif": aktif,
      };
}
