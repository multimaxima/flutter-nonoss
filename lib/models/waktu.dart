// To parse this JSON data, do
//
//     final waktuModels = waktuModelsFromJson(jsonString);

import 'dart:convert';

WaktuModels waktuModelsFromJson(String str) =>
    WaktuModels.fromJson(json.decode(str));

String waktuModelsToJson(WaktuModels data) => json.encode(data.toJson());

class WaktuModels {
  WaktuModels({
    this.id,
    this.idPermohonan,
    this.tampil,
    this.idDinas,
    this.kode,
    this.dinas,
    this.waktu,
    this.waktuHistory,
    this.keterangan,
    this.catatan,
  });

  int? id;
  int? idPermohonan;
  int? tampil;
  int? idDinas;
  String? kode;
  String? dinas;
  String? waktu;
  String? waktuHistory;
  String? keterangan;
  String? catatan;

  factory WaktuModels.fromJson(Map<String, dynamic> json) => WaktuModels(
        id: json["id"],
        idPermohonan: json["id_permohonan"],
        tampil: json["tampil"],
        idDinas: json["id_dinas"],
        kode: json["kode"],
        dinas: json["dinas"],
        waktu: json["waktu"],
        waktuHistory: json["waktu_history"],
        keterangan: json["keterangan"],
        catatan: json["catatan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_permohonan": idPermohonan,
        "tampil": tampil,
        "id_dinas": idDinas,
        "kode": kode,
        "dinas": dinas,
        "waktu": waktu,
        "waktu_history": waktuHistory,
        "keterangan": keterangan,
        "catatan": catatan,
      };
}
