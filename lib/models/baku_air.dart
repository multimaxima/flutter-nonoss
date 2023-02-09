// To parse this JSON data, do
//
//     final bakuAirModels = bakuAirModelsFromJson(jsonString);

import 'dart:convert';

BakuAirModels bakuAirModelsFromJson(String str) =>
    BakuAirModels.fromJson(json.decode(str));

String bakuAirModelsToJson(BakuAirModels data) => json.encode(data.toJson());

class BakuAirModels {
  BakuAirModels({
    this.id,
    this.variabel,
    this.penghuni,
    this.penghuniX,
    this.jamaah,
    this.jamaahMandiX,
    this.jamaahWudluX,
    this.siswa,
    this.siswaX,
    this.karyawan,
    this.karyawanX,
    this.lBangunan,
    this.lBangunanX,
    this.kursi,
    this.kursiX,
    this.kebutuhan,
    this.sd,
    this.sdX,
    this.smp,
    this.smpX,
    this.sma,
    this.smaX,
    this.pt,
    this.ptX,
    this.tambakLuas,
    this.tambakIntensitas,
    this.tambakX,
    this.tokoLuas,
    this.tokoLuasX,
    this.aktif,
  });

  int? id;
  String? variabel;
  int? penghuni;
  int? penghuniX;
  int? jamaah;
  int? jamaahMandiX;
  int? jamaahWudluX;
  int? siswa;
  int? siswaX;
  int? karyawan;
  int? karyawanX;
  int? lBangunan;
  int? lBangunanX;
  int? kursi;
  int? kursiX;
  int? kebutuhan;
  int? sd;
  int? sdX;
  int? smp;
  int? smpX;
  int? sma;
  int? smaX;
  int? pt;
  int? ptX;
  int? tambakLuas;
  int? tambakIntensitas;
  int? tambakX;
  int? tokoLuas;
  int? tokoLuasX;
  int? aktif;

  factory BakuAirModels.fromJson(Map<String, dynamic> json) => BakuAirModels(
        id: json["id"],
        variabel: json["variabel"],
        penghuni: json["penghuni"],
        penghuniX: json["penghuni_x"],
        jamaah: json["jamaah"],
        jamaahMandiX: json["jamaah_mandi_x"],
        jamaahWudluX: json["jamaah_wudlu_x"],
        siswa: json["siswa"],
        siswaX: json["siswa_x"],
        karyawan: json["karyawan"],
        karyawanX: json["karyawan_x"],
        lBangunan: json["l_bangunan"],
        lBangunanX: json["l_bangunan_x"],
        kursi: json["kursi"],
        kursiX: json["kursi_x"],
        kebutuhan: json["kebutuhan"],
        sd: json["sd"],
        sdX: json["sd_x"],
        smp: json["smp"],
        smpX: json["smp_x"],
        sma: json["sma"],
        smaX: json["sma_x"],
        pt: json["pt"],
        ptX: json["pt_x"],
        tambakLuas: json["tambak_luas"],
        tambakIntensitas: json["tambak_intensitas"],
        tambakX: json["tambak_x"],
        tokoLuas: json["toko_luas"],
        tokoLuasX: json["toko_luas_x"],
        aktif: json["aktif"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "variabel": variabel,
        "penghuni": penghuni,
        "penghuni_x": penghuniX,
        "jamaah": jamaah,
        "jamaah_mandi_x": jamaahMandiX,
        "jamaah_wudlu_x": jamaahWudluX,
        "siswa": siswa,
        "siswa_x": siswaX,
        "karyawan": karyawan,
        "karyawan_x": karyawanX,
        "l_bangunan": lBangunan,
        "l_bangunan_x": lBangunanX,
        "kursi": kursi,
        "kursi_x": kursiX,
        "kebutuhan": kebutuhan,
        "sd": sd,
        "sd_x": sdX,
        "smp": smp,
        "smp_x": smpX,
        "sma": sma,
        "sma_x": smaX,
        "pt": pt,
        "pt_x": ptX,
        "tambak_luas": tambakLuas,
        "tambak_intensitas": tambakIntensitas,
        "tambak_x": tambakX,
        "toko_luas": tokoLuas,
        "toko_luas_x": tokoLuasX,
        "aktif": aktif,
      };
}
