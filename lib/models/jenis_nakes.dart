import 'dart:convert';

JenisNakesModels jenisNakesModelsFromJson(String str) =>
    JenisNakesModels.fromJson(json.decode(str));

String jenisNakesModelsToJson(JenisNakesModels data) =>
    json.encode(data.toJson());

class JenisNakesModels {
  JenisNakesModels({
    this.id,
    this.idIzin,
    this.izin,
    this.kode,
    this.jml,
    this.fasyankes,
    this.mandiri,
    this.distribusi,
    this.produksi,
    this.keterangan,
    this.pendTerakhir,
    this.noSertifikat,
    this.noStr,
    this.noRekomOp,
    this.ketSehat,
    this.spMematuhi,
    this.spTempPraktek,
    this.skFasyankes,
    this.spAtasan,
    this.skKomiteInterensif,
    this.rekomDinkes,
    this.suratIzinSebelum,
    this.idSuratPermohonan,
    this.idSuratSk,
    this.idSuratRekom,
    this.idSuratRekomendasi,
    this.idSuratRekomendasiMandiri,
    this.idStafTte,
    this.pendTerakhirMandiri,
    this.noSertifikatMandiri,
    this.noStrMandiri,
    this.noRekomOpMandiri,
    this.ketSehatMandiri,
    this.spMematuhiMandiri,
    this.spTempPraktekMandiri,
    this.skFasyankesMandiri,
    this.spAtasanMandiri,
    this.skKomiteInterensifMandiri,
    this.rekomDinkesMandiri,
    this.suratIzinSebelumMandiri,
    this.pendTerakhirDistribusi,
    this.noSertifikatDistribusi,
    this.noStrDistribusi,
    this.noRekomOpDistribusi,
    this.ketSehatDistribusi,
    this.spMematuhiDistribusi,
    this.spTempPraktekDistribusi,
    this.skFasyankesDistribusi,
    this.spAtasanDistribusi,
    this.skKomiteInterensifDistribusi,
    this.rekomDinkesDistribusi,
    this.suratIzinSebelumDistribusi,
    this.pendTerakhirProduksi,
    this.noSertifikatProduksi,
    this.noStrProduksi,
    this.noRekomOpProduksi,
    this.ketSehatProduksi,
    this.spMematuhiProduksi,
    this.spTempPraktekProduksi,
    this.skFasyankesProduksi,
    this.spAtasanProduksi,
    this.skKomiteInterensifProduksi,
    this.rekomDinkesProduksi,
    this.suratIzinSebelumProduksi,
    this.asosiasi,
  });

  int? id;
  int? idIzin;
  String? izin;
  String? kode;
  int? jml;
  int? fasyankes;
  int? mandiri;
  int? distribusi;
  int? produksi;
  String? keterangan;
  int? pendTerakhir;
  int? noSertifikat;
  int? noStr;
  int? noRekomOp;
  int? ketSehat;
  int? spMematuhi;
  int? spTempPraktek;
  int? skFasyankes;
  int? spAtasan;
  int? skKomiteInterensif;
  int? rekomDinkes;
  int? suratIzinSebelum;
  int? idSuratPermohonan;
  int? idSuratSk;
  int? idSuratRekom;
  int? idSuratRekomendasi;
  int? idSuratRekomendasiMandiri;
  int? idStafTte;
  int? pendTerakhirMandiri;
  int? noSertifikatMandiri;
  int? noStrMandiri;
  int? noRekomOpMandiri;
  int? ketSehatMandiri;
  int? spMematuhiMandiri;
  int? spTempPraktekMandiri;
  int? skFasyankesMandiri;
  int? spAtasanMandiri;
  int? skKomiteInterensifMandiri;
  int? rekomDinkesMandiri;
  int? suratIzinSebelumMandiri;
  int? pendTerakhirDistribusi;
  int? noSertifikatDistribusi;
  int? noStrDistribusi;
  int? noRekomOpDistribusi;
  int? ketSehatDistribusi;
  int? spMematuhiDistribusi;
  int? spTempPraktekDistribusi;
  int? skFasyankesDistribusi;
  int? spAtasanDistribusi;
  int? skKomiteInterensifDistribusi;
  int? rekomDinkesDistribusi;
  int? suratIzinSebelumDistribusi;
  int? pendTerakhirProduksi;
  int? noSertifikatProduksi;
  int? noStrProduksi;
  int? noRekomOpProduksi;
  int? ketSehatProduksi;
  int? spMematuhiProduksi;
  int? spTempPraktekProduksi;
  int? skFasyankesProduksi;
  int? spAtasanProduksi;
  int? skKomiteInterensifProduksi;
  int? rekomDinkesProduksi;
  int? suratIzinSebelumProduksi;
  String? asosiasi;

  factory JenisNakesModels.fromJson(Map<String, dynamic> json) =>
      JenisNakesModels(
        id: json["id"],
        idIzin: json["id_izin"],
        izin: json["izin"],
        kode: json["kode"],
        jml: json["jml"],
        fasyankes: json["fasyankes"],
        mandiri: json["mandiri"],
        distribusi: json["distribusi"],
        produksi: json["produksi"],
        keterangan: json["keterangan"],
        pendTerakhir: json["pend_terakhir"],
        noSertifikat: json["no_sertifikat"],
        noStr: json["no_str"],
        noRekomOp: json["no_rekom_op"],
        ketSehat: json["ket_sehat"],
        spMematuhi: json["sp_mematuhi"],
        spTempPraktek: json["sp_temp_praktek"],
        skFasyankes: json["sk_fasyankes"],
        spAtasan: json["sp_atasan"],
        skKomiteInterensif: json["sk_komite_interensif"],
        rekomDinkes: json["rekom_dinkes"],
        suratIzinSebelum: json["surat_izin_sebelum"],
        idSuratPermohonan: json["id_surat_permohonan"],
        idSuratSk: json["id_surat_sk"],
        idSuratRekom: json["id_surat_rekom"],
        idSuratRekomendasi: json["id_surat_rekomendasi"],
        idSuratRekomendasiMandiri: json["id_surat_rekomendasi_mandiri"],
        idStafTte: json["id_staf_tte"],
        pendTerakhirMandiri: json["pend_terakhir_mandiri"],
        noSertifikatMandiri: json["no_sertifikat_mandiri"],
        noStrMandiri: json["no_str_mandiri"],
        noRekomOpMandiri: json["no_rekom_op_mandiri"],
        ketSehatMandiri: json["ket_sehat_mandiri"],
        spMematuhiMandiri: json["sp_mematuhi_mandiri"],
        spTempPraktekMandiri: json["sp_temp_praktek_mandiri"],
        skFasyankesMandiri: json["sk_fasyankes_mandiri"],
        spAtasanMandiri: json["sp_atasan_mandiri"],
        skKomiteInterensifMandiri: json["sk_komite_interensif_mandiri"],
        rekomDinkesMandiri: json["rekom_dinkes_mandiri"],
        suratIzinSebelumMandiri: json["surat_izin_sebelum_mandiri"],
        pendTerakhirDistribusi: json["pend_terakhir_distribusi"],
        noSertifikatDistribusi: json["no_sertifikat_distribusi"],
        noStrDistribusi: json["no_str_distribusi"],
        noRekomOpDistribusi: json["no_rekom_op_distribusi"],
        ketSehatDistribusi: json["ket_sehat_distribusi"],
        spMematuhiDistribusi: json["sp_mematuhi_distribusi"],
        spTempPraktekDistribusi: json["sp_temp_praktek_distribusi"],
        skFasyankesDistribusi: json["sk_fasyankes_distribusi"],
        spAtasanDistribusi: json["sp_atasan_distribusi"],
        skKomiteInterensifDistribusi: json["sk_komite_interensif_distribusi"],
        rekomDinkesDistribusi: json["rekom_dinkes_distribusi"],
        suratIzinSebelumDistribusi: json["surat_izin_sebelum_distribusi"],
        pendTerakhirProduksi: json["pend_terakhir_produksi"],
        noSertifikatProduksi: json["no_sertifikat_produksi"],
        noStrProduksi: json["no_str_produksi"],
        noRekomOpProduksi: json["no_rekom_op_produksi"],
        ketSehatProduksi: json["ket_sehat_produksi"],
        spMematuhiProduksi: json["sp_mematuhi_produksi"],
        spTempPraktekProduksi: json["sp_temp_praktek_produksi"],
        skFasyankesProduksi: json["sk_fasyankes_produksi"],
        spAtasanProduksi: json["sp_atasan_produksi"],
        skKomiteInterensifProduksi: json["sk_komite_interensif_produksi"],
        rekomDinkesProduksi: json["rekom_dinkes_produksi"],
        suratIzinSebelumProduksi: json["surat_izin_sebelum_produksi"],
        asosiasi: json["asosiasi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_izin": idIzin,
        "izin": izin,
        "kode": kode,
        "jml": jml,
        "fasyankes": fasyankes,
        "mandiri": mandiri,
        "distribusi": distribusi,
        "produksi": produksi,
        "keterangan": keterangan,
        "pend_terakhir": pendTerakhir,
        "no_sertifikat": noSertifikat,
        "no_str": noStr,
        "no_rekom_op": noRekomOp,
        "ket_sehat": ketSehat,
        "sp_mematuhi": spMematuhi,
        "sp_temp_praktek": spTempPraktek,
        "sk_fasyankes": skFasyankes,
        "sp_atasan": spAtasan,
        "sk_komite_interensif": skKomiteInterensif,
        "rekom_dinkes": rekomDinkes,
        "surat_izin_sebelum": suratIzinSebelum,
        "id_surat_permohonan": idSuratPermohonan,
        "id_surat_sk": idSuratSk,
        "id_surat_rekom": idSuratRekom,
        "id_surat_rekomendasi": idSuratRekomendasi,
        "id_surat_rekomendasi_mandiri": idSuratRekomendasiMandiri,
        "id_staf_tte": idStafTte,
        "pend_terakhir_mandiri": pendTerakhirMandiri,
        "no_sertifikat_mandiri": noSertifikatMandiri,
        "no_str_mandiri": noStrMandiri,
        "no_rekom_op_mandiri": noRekomOpMandiri,
        "ket_sehat_mandiri": ketSehatMandiri,
        "sp_mematuhi_mandiri": spMematuhiMandiri,
        "sp_temp_praktek_mandiri": spTempPraktekMandiri,
        "sk_fasyankes_mandiri": skFasyankesMandiri,
        "sp_atasan_mandiri": spAtasanMandiri,
        "sk_komite_interensif_mandiri": skKomiteInterensifMandiri,
        "rekom_dinkes_mandiri": rekomDinkesMandiri,
        "surat_izin_sebelum_mandiri": suratIzinSebelumMandiri,
        "pend_terakhir_distribusi": pendTerakhirDistribusi,
        "no_sertifikat_distribusi": noSertifikatDistribusi,
        "no_str_distribusi": noStrDistribusi,
        "no_rekom_op_distribusi": noRekomOpDistribusi,
        "ket_sehat_distribusi": ketSehatDistribusi,
        "sp_mematuhi_distribusi": spMematuhiDistribusi,
        "sp_temp_praktek_distribusi": spTempPraktekDistribusi,
        "sk_fasyankes_distribusi": skFasyankesDistribusi,
        "sp_atasan_distribusi": spAtasanDistribusi,
        "sk_komite_interensif_distribusi": skKomiteInterensifDistribusi,
        "rekom_dinkes_distribusi": rekomDinkesDistribusi,
        "surat_izin_sebelum_distribusi": suratIzinSebelumDistribusi,
        "pend_terakhir_produksi": pendTerakhirProduksi,
        "no_sertifikat_produksi": noSertifikatProduksi,
        "no_str_produksi": noStrProduksi,
        "no_rekom_op_produksi": noRekomOpProduksi,
        "ket_sehat_produksi": ketSehatProduksi,
        "sp_mematuhi_produksi": spMematuhiProduksi,
        "sp_temp_praktek_produksi": spTempPraktekProduksi,
        "sk_fasyankes_produksi": skFasyankesProduksi,
        "sp_atasan_produksi": spAtasanProduksi,
        "sk_komite_interensif_produksi": skKomiteInterensifProduksi,
        "rekom_dinkes_produksi": rekomDinkesProduksi,
        "surat_izin_sebelum_produksi": suratIzinSebelumProduksi,
        "asosiasi": asosiasi,
      };
}
