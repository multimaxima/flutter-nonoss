// To parse this JSON data, do
//
//     final jenisKegiatanKkpr = jenisKegiatanKkprFromJson(jsonString);

import 'dart:convert';

JenisKegiatanKkpr jenisKegiatanKkprFromJson(String str) =>
    JenisKegiatanKkpr.fromJson(json.decode(str));

String jenisKegiatanKkprToJson(JenisKegiatanKkpr data) =>
    json.encode(data.toJson());

class JenisKegiatanKkpr {
  JenisKegiatanKkpr({
    this.id,
    this.kategori,
    this.jenis,
    this.diskripsi,
    this.perorangan,
    this.perusahaan,
    this.yayasan,
    this.pemerintah,
    this.pernyataanMandiri,
    this.kkprOtomatis,
    this.iprLama,
  });

  int? id;
  String? kategori;
  String? jenis;
  String? diskripsi;
  int? perorangan;
  int? perusahaan;
  int? yayasan;
  int? pemerintah;
  int? pernyataanMandiri;
  int? kkprOtomatis;
  int? iprLama;

  factory JenisKegiatanKkpr.fromJson(Map<String, dynamic> json) =>
      JenisKegiatanKkpr(
        id: json["id"],
        kategori: json["kategori"],
        jenis: json["jenis"],
        diskripsi: json["diskripsi"],
        perorangan: json["perorangan"],
        perusahaan: json["perusahaan"],
        yayasan: json["yayasan"],
        pemerintah: json["pemerintah"],
        pernyataanMandiri: json["pernyataan_mandiri"],
        kkprOtomatis: json["kkpr_otomatis"],
        iprLama: json["ipr_lama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kategori": kategori,
        "jenis": jenis,
        "diskripsi": diskripsi,
        "perorangan": perorangan,
        "perusahaan": perusahaan,
        "yayasan": yayasan,
        "pemerintah": pemerintah,
        "pernyataan_mandiri": pernyataanMandiri,
        "kkpr_otomatis": kkprOtomatis,
        "ipr_lama": iprLama,
      };
}
