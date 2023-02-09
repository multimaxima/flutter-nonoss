// To parse this JSON data, do
//
//     final statusTanahModels = statusTanahModelsFromJson(jsonString);

import 'dart:convert';

StatusTanahModels statusTanahModelsFromJson(String str) => StatusTanahModels.fromJson(json.decode(str));

String statusTanahModelsToJson(StatusTanahModels data) => json.encode(data.toJson());

class StatusTanahModels {
  StatusTanahModels({
    this.id,
    this.statusTanah,
    this.kode,
    this.keterangan,
  });

  int? id;
  String? statusTanah;
  String? kode;
  String? keterangan;

  factory StatusTanahModels.fromJson(Map<String, dynamic> json) => StatusTanahModels(
        id: json["id"],
        statusTanah: json["status_tanah"],
        kode: json["kode"],
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status_tanah": statusTanah,
        "kode": kode,
        "keterangan": keterangan,
      };
}
