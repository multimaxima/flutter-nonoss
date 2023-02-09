// To parse this JSON data, do
//
//     final jenisReklameModels = jenisReklameModelsFromJson(jsonString);

import 'dart:convert';

JenisReklameModels jenisReklameModelsFromJson(String str) =>
    JenisReklameModels.fromJson(json.decode(str));

String jenisReklameModelsToJson(JenisReklameModels data) =>
    json.encode(data.toJson());

class JenisReklameModels {
  JenisReklameModels({
    this.id,
    this.idKategori,
    this.jenis,
    this.singkatan,
    this.diskripsi,
    this.tetap,
    this.masaBerlaku,
    this.masa,
    this.jenisRek,
    this.alamat,
    this.area,
    this.lahan,
    this.zona,
    this.sisi,
    this.ketJenis,
    this.ukuran,
    this.tinggi,
    this.diameterTiang,
    this.lembar,
    this.item,
    this.kordinat,
    this.imb,
    this.kkpr,
    this.rtbb,
    this.asuransi,
    this.sondir,
    this.slf,
    this.fotoLokasi,
    this.fotoMateri,
    this.tl,
    this.verifKasi,
    this.verifKabid,
    this.verifKadis,
    this.stiker,
    this.sk,
    this.aktif,
    this.nibPerorangan,
    this.npwpPerorangan,
    this.npwpdPerorangan,
    this.nibBadan,
    this.npwpBadan,
    this.npwpdBadan,
    this.nibVendor,
    this.npwpVendor,
    this.npwpdVendor,
  });

  int? id;
  int? idKategori;
  String? jenis;
  String? singkatan;
  String? diskripsi;
  int? tetap;
  int? masaBerlaku;
  String? masa;
  int? jenisRek;
  int? alamat;
  int? area;
  int? lahan;
  int? zona;
  int? sisi;
  int? ketJenis;
  int? ukuran;
  int? tinggi;
  int? diameterTiang;
  int? lembar;
  int? item;
  int? kordinat;
  int? imb;
  int? kkpr;
  int? rtbb;
  int? asuransi;
  int? sondir;
  int? slf;
  int? fotoLokasi;
  int? fotoMateri;
  int? tl;
  int? verifKasi;
  int? verifKabid;
  int? verifKadis;
  int? stiker;
  int? sk;
  int? aktif;
  int? nibPerorangan;
  int? npwpPerorangan;
  int? npwpdPerorangan;
  int? nibBadan;
  int? npwpBadan;
  int? npwpdBadan;
  int? nibVendor;
  int? npwpVendor;
  int? npwpdVendor;

  factory JenisReklameModels.fromJson(Map<String, dynamic> json) =>
      JenisReklameModels(
        id: json["id"],
        idKategori: json["id_kategori"],
        jenis: json["jenis"],
        singkatan: json["singkatan"],
        diskripsi: json["diskripsi"],
        tetap: json["tetap"],
        masaBerlaku: json["masa_berlaku"],
        masa: json["masa"],
        jenisRek: json["jenis_rek"],
        alamat: json["alamat"],
        area: json["area"],
        lahan: json["lahan"],
        zona: json["zona"],
        sisi: json["sisi"],
        ketJenis: json["ket_jenis"],
        ukuran: json["ukuran"],
        tinggi: json["tinggi"],
        diameterTiang: json["diameter_tiang"],
        lembar: json["lembar"],
        item: json["item"],
        kordinat: json["kordinat"],
        imb: json["imb"],
        kkpr: json["kkpr"],
        rtbb: json["rtbb"],
        asuransi: json["asuransi"],
        sondir: json["sondir"],
        slf: json["slf"],
        fotoLokasi: json["foto_lokasi"],
        fotoMateri: json["foto_materi"],
        tl: json["tl"],
        verifKasi: json["verif_kasi"],
        verifKabid: json["verif_kabid"],
        verifKadis: json["verif_kadis"],
        stiker: json["stiker"],
        sk: json["sk"],
        aktif: json["aktif"],
        nibPerorangan: json["nib_perorangan"],
        npwpPerorangan: json["npwp_perorangan"],
        npwpdPerorangan: json["npwpd_perorangan"],
        nibBadan: json["nib_badan"],
        npwpBadan: json["npwp_badan"],
        npwpdBadan: json["npwpd_badan"],
        nibVendor: json["nib_vendor"],
        npwpVendor: json["npwp_vendor"],
        npwpdVendor: json["npwpd_vendor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_kategori": idKategori,
        "jenis": jenis,
        "singkatan": singkatan,
        "diskripsi": diskripsi,
        "tetap": tetap,
        "masa_berlaku": masaBerlaku,
        "masa": masa,
        "jenis_rek": jenisRek,
        "alamat": alamat,
        "area": area,
        "lahan": lahan,
        "zona": zona,
        "sisi": sisi,
        "ket_jenis": ketJenis,
        "ukuran": ukuran,
        "tinggi": tinggi,
        "diameter_tiang": diameterTiang,
        "lembar": lembar,
        "item": item,
        "kordinat": kordinat,
        "imb": imb,
        "kkpr": kkpr,
        "rtbb": rtbb,
        "asuransi": asuransi,
        "sondir": sondir,
        "slf": slf,
        "foto_lokasi": fotoLokasi,
        "foto_materi": fotoMateri,
        "tl": tl,
        "verif_kasi": verifKasi,
        "verif_kabid": verifKabid,
        "verif_kadis": verifKadis,
        "stiker": stiker,
        "sk": sk,
        "aktif": aktif,
        "nib_perorangan": nibPerorangan,
        "npwp_perorangan": npwpPerorangan,
        "npwpd_perorangan": npwpdPerorangan,
        "nib_badan": nibBadan,
        "npwp_badan": npwpBadan,
        "npwpd_badan": npwpdBadan,
        "nib_vendor": nibVendor,
        "npwp_vendor": npwpVendor,
        "npwpd_vendor": npwpdVendor,
      };
}
