// To parse this JSON data, do
//
//     final kkprTanahModels = kkprTanahModelsFromJson(jsonString);

import 'dart:convert';

KkprTanahModels kkprTanahModelsFromJson(String str) =>
    KkprTanahModels.fromJson(json.decode(str));

String kkprTanahModelsToJson(KkprTanahModels data) =>
    json.encode(data.toJson());

class KkprTanahModels {
  KkprTanahModels({
    this.id,
    this.idPermohonanPkkprTemp,
    this.statusLahan,
    this.nomorAkta,
    this.tahunAkta,
    this.atasNamaAkta,
    this.luasAkta,
    this.suratUkur,
    this.dokAkta,
    this.suketKematian,
    this.suketWaris,
    this.perjanjianSewa,
    this.perikatanJualBeli,
    this.ajb,
    this.pernyataanPemilikTanah,
    this.akteHibah,
    this.pinjamPakai,
    this.petaBidang,
    this.suratUkurTgl,
    this.keadaanTanah,
    this.namaSendiri,
    this.statusTanah,
    this.kode,
  });

  int? id;
  int? idPermohonanPkkprTemp;
  int? statusLahan;
  String? nomorAkta;
  String? tahunAkta;
  String? atasNamaAkta;
  String? luasAkta;
  String? suratUkur;
  String? dokAkta;
  String? suketKematian;
  String? suketWaris;
  String? perjanjianSewa;
  String? perikatanJualBeli;
  String? ajb;
  String? pernyataanPemilikTanah;
  String? akteHibah;
  String? pinjamPakai;
  String? petaBidang;
  DateTime? suratUkurTgl;
  String? keadaanTanah;
  int? namaSendiri;
  String? statusTanah;
  String? kode;

  factory KkprTanahModels.fromJson(Map<String, dynamic> json) =>
      KkprTanahModels(
        id: json["id"],
        idPermohonanPkkprTemp: json["id_permohonan_pkkpr_temp"],
        statusLahan: json["status_lahan"],
        nomorAkta: json["nomor_akta"],
        tahunAkta: json["tahun_akta"],
        atasNamaAkta: json["atas_nama_akta"],
        luasAkta: json["luas_akta"],
        suratUkur: json["surat_ukur"],
        dokAkta: json["dok_akta"],
        suketKematian: json["suket_kematian"],
        suketWaris: json["suket_waris"],
        perjanjianSewa: json["perjanjian_sewa"],
        perikatanJualBeli: json["perikatan_jual_beli"],
        ajb: json["ajb"],
        pernyataanPemilikTanah: json["pernyataan_pemilik_tanah"],
        akteHibah: json["akte_hibah"],
        pinjamPakai: json["pinjam_pakai"],
        petaBidang: json["peta_bidang"],
        suratUkurTgl: DateTime.parse(json["surat_ukur_tgl"]),
        keadaanTanah: json["keadaan_tanah"],
        namaSendiri: json["nama_sendiri"],
        statusTanah: json["status_tanah"],
        kode: json["kode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_permohonan_pkkpr_temp": idPermohonanPkkprTemp,
        "status_lahan": statusLahan,
        "nomor_akta": nomorAkta,
        "tahun_akta": tahunAkta,
        "atas_nama_akta": atasNamaAkta,
        "luas_akta": luasAkta,
        "surat_ukur": suratUkur,
        "dok_akta": dokAkta,
        "suket_kematian": suketKematian,
        "suket_waris": suketWaris,
        "perjanjian_sewa": perjanjianSewa,
        "perikatan_jual_beli": perikatanJualBeli,
        "ajb": ajb,
        "pernyataan_pemilik_tanah": pernyataanPemilikTanah,
        "akte_hibah": akteHibah,
        "pinjam_pakai": pinjamPakai,
        "peta_bidang": petaBidang,
        "surat_ukur_tgl":
            "${suratUkurTgl!.year.toString().padLeft(4, '0')}-${suratUkurTgl!.month.toString().padLeft(2, '0')}-${suratUkurTgl!.day.toString().padLeft(2, '0')}",
        "keadaan_tanah": keadaanTanah,
        "nama_sendiri": namaSendiri,
        "status_tanah": statusTanah,
        "kode": kode,
      };
}
