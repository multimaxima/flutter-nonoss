// To parse this JSON data, do
//
//     final permohonanModels = permohonanModelsFromJson(jsonString);

import 'dart:convert';

PermohonanModels permohonanModelsFromJson(String str) =>
    PermohonanModels.fromJson(json.decode(str));

String permohonanModelsToJson(PermohonanModels data) =>
    json.encode(data.toJson());

class PermohonanModels {
  PermohonanModels({
    this.id,
    this.nomorDaftar,
    this.register,
    this.idIzin,
    this.tahun,
    this.waktuPermohonan,
    this.jamPermohonan,
    this.revisi,
    this.sk,
    this.verifDinkes,
    this.ikm,
    this.nomor,
    this.pnbp,
    this.sps,
    this.batal,
    this.kode,
    this.keterangan,
    this.catatan,
    this.dinas,
    this.izin,
    this.kodes,
    this.ditolak,
  });

  int? id;
  int? nomorDaftar;
  String? register;
  int? idIzin;
  String? tahun;
  String? waktuPermohonan;
  String? jamPermohonan;
  int? revisi;
  String? sk;
  int? verifDinkes;
  int? ikm;
  String? nomor;
  int? pnbp;
  int? sps;
  int? batal;
  String? kode;
  String? keterangan;
  String? catatan;
  String? dinas;
  String? izin;
  String? kodes;
  int? ditolak;

  factory PermohonanModels.fromJson(Map<String, dynamic> json) =>
      PermohonanModels(
        id: json["id"],
        nomorDaftar: json["nomor_daftar"],
        register: json["register"],
        idIzin: json["id_izin"],
        tahun: json["tahun"],
        waktuPermohonan: json["waktu_permohonan"],
        jamPermohonan: json["jam_permohonan"],
        revisi: json["revisi"],
        sk: json["sk"],
        verifDinkes: json["verif_dinkes"],
        ikm: json["ikm"],
        nomor: json["nomor"],
        pnbp: json["pnbp"],
        sps: json["sps"],
        batal: json["batal"],
        kode: json["kode"],
        keterangan: json["keterangan"],
        catatan: json["catatan"],
        dinas: json["dinas"],
        izin: json["izin"],
        kodes: json["kodes"],
        ditolak: json["ditolak"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nomor_daftar": nomorDaftar,
        "register": register,
        "id_izin": idIzin,
        "tahun": tahun,
        "waktu_permohonan": waktuPermohonan,
        "jam_permohonan": jamPermohonan,
        "revisi": revisi,
        "sk": sk,
        "verif_dinkes": verifDinkes,
        "ikm": ikm,
        "nomor": nomor,
        "pnbp": pnbp,
        "sps": sps,
        "batal": batal,
        "kode": kode,
        "keterangan": keterangan,
        "catatan": catatan,
        "dinas": dinas,
        "izin": izin,
        "kodes": kodes,
        "ditolak": ditolak,
      };
}
