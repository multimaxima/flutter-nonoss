// To parse this JSON data, do
//
//     final kkprRincianTanahModels = kkprRincianTanahModelsFromJson(jsonString);

import 'dart:convert';

KkprRincianTanahModels kkprRincianTanahModelsFromJson(String str) =>
    KkprRincianTanahModels.fromJson(json.decode(str));

String kkprRincianTanahModelsToJson(KkprRincianTanahModels data) =>
    json.encode(data.toJson());

class KkprRincianTanahModels {
  KkprRincianTanahModels({
    this.id,
    this.idPermohonan,
    this.idPermohonanPkkpr,
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
    this.petaBidang,
    this.statusTanah,
    this.suratUkurTgl,
    this.keadaanTanah,
    this.keterangan,
    this.kode,
  });

  int? id;
  int? idPermohonan;
  int? idPermohonanPkkpr;
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
  String? petaBidang;
  String? statusTanah;
  String? suratUkurTgl;
  String? keadaanTanah;
  String? keterangan;
  String? kode;

  factory KkprRincianTanahModels.fromJson(Map<String, dynamic> json) =>
      KkprRincianTanahModels(
        id: json["id"],
        idPermohonan: json["id_permohonan"],
        idPermohonanPkkpr: json["id_permohonan_pkkpr"],
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
        petaBidang: json["peta_bidang"],
        statusTanah: json["status_tanah"],
        suratUkurTgl: json["surat_ukur_tgl"],
        keadaanTanah: json["keadaan_tanah"],
        keterangan: json["keterangan"],
        kode: json["kode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_permohonan": idPermohonan,
        "id_permohonan_pkkpr": idPermohonanPkkpr,
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
        "peta_bidang": petaBidang,
        "status_tanah": statusTanah,
        "surat_ukur_tgl": suratUkurTgl,
        "keadaan_tanah": keadaanTanah,
        "keterangan": keterangan,
        "kode": kode,
      };
}
