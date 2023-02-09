// To parse this JSON data, do
//
//     final userModels = userModelsFromJson(jsonString);

import 'dart:convert';

UserModels userModelsFromJson(String str) =>
    UserModels.fromJson(json.decode(str));

String userModelsToJson(UserModels data) => json.encode(data.toJson());

class UserModels {
  UserModels({
    this.id,
    this.uid,
    this.smartId,
    this.idVendor,
    this.vendor,
    this.jenis,
    this.idNpwpd,
    this.nama,
    this.gelarDepan,
    this.gelarBelakang,
    this.alamat,
    this.dusun,
    this.rt,
    this.rw,
    this.noProp,
    this.noKab,
    this.noKec,
    this.noKel,
    this.kelurahan,
    this.kecamatan,
    this.kota,
    this.propinsi,
    this.kodepos,
    this.lat,
    this.lng,
    this.nik,
    this.verifNik,
    this.paspor,
    this.kk,
    this.npwp,
    this.npwpd,
    this.npwpdValid,
    this.idNpwpdEpad,
    this.tempLahir,
    this.tglLahir,
    this.pekerjaan,
    this.telp,
    this.hp,
    this.hp1,
    this.whatsapp,
    this.foto,
    this.dokKtp,
    this.dokPaspor,
    this.dokKk,
    this.dokNpwp,
    this.dokNpwpd,
    this.kelamin,
    this.jenisKelamin,
    this.warganegara,
    this.jenisWarganegara,
    this.negara,
    this.idBadan,
    this.namaBadan,
    this.alamatBadan,
    this.dusunBadan,
    this.rtBadan,
    this.rwBadan,
    this.noPropBadan,
    this.noKabBadan,
    this.noKecBadan,
    this.noKelBadan,
    this.kelurahanBadan,
    this.kecamatanBadan,
    this.kotaBadan,
    this.propinsiBadan,
    this.kodeposBadan,
    this.telpBadan,
    this.faxBadan,
    this.skBadan,
    this.ahuBadan,
    this.jabatan,
    this.kopSurat,
    this.nib,
    this.dokAkta,
    this.dokAhu,
    this.dokNib,
    this.pendidikanTerakhir,
    this.lembagaPendidikan,
    this.noIjasah,
    this.tglIjasah,
    this.dokIjasah,
    this.sertKompetensi,
    this.tglSertKompetensi,
    this.dokSertKompetensi,
    this.strNo,
    this.strBerlaku,
    this.strTanggal,
    this.strAsal,
    this.dokStr,
    this.rekomOp,
    this.tglRekomOp,
    this.dokRekomOp,
    this.nim,
    this.dokNim,
    this.lembaga,
    this.fakultas,
    this.jurusan,
    this.revisi,
    this.ketRevisi,
    this.email,
    this.emailVerifiedAt,
    this.password,
    this.rememberToken,
    this.hapus,
    this.createdAt,
    this.updatedAt,
    this.petugasCreate,
    this.petugasUpdate,
    this.ket,
  });

  int? id;
  String? uid;
  String? smartId;
  int? idVendor;
  int? vendor;
  int? jenis;
  int? idNpwpd;
  String? nama;
  String? gelarDepan;
  String? gelarBelakang;
  String? alamat;
  String? dusun;
  String? rt;
  String? rw;
  String? noProp;
  String? noKab;
  String? noKec;
  String? noKel;
  String? kelurahan;
  String? kecamatan;
  String? kota;
  String? propinsi;
  String? kodepos;
  double? lat;
  double? lng;
  String? nik;
  int? verifNik;
  String? paspor;
  String? kk;
  String? npwp;
  String? npwpd;
  int? npwpdValid;
  int? idNpwpdEpad;
  String? tempLahir;
  String? tglLahir;
  String? pekerjaan;
  String? telp;
  String? hp;
  String? hp1;
  String? whatsapp;
  String? foto;
  String? dokKtp;
  String? dokPaspor;
  String? dokKk;
  String? dokNpwp;
  String? dokNpwpd;
  int? kelamin;
  String? jenisKelamin;
  int? warganegara;
  String? jenisWarganegara;
  String? negara;
  int? idBadan;
  String? namaBadan;
  String? alamatBadan;
  String? dusunBadan;
  String? rtBadan;
  String? rwBadan;
  String? noPropBadan;
  String? noKabBadan;
  String? noKecBadan;
  String? noKelBadan;
  String? kelurahanBadan;
  String? kecamatanBadan;
  String? kotaBadan;
  String? propinsiBadan;
  String? kodeposBadan;
  String? telpBadan;
  String? faxBadan;
  String? skBadan;
  String? ahuBadan;
  String? jabatan;
  String? kopSurat;
  String? nib;
  String? dokAkta;
  String? dokAhu;
  String? dokNib;
  String? pendidikanTerakhir;
  String? lembagaPendidikan;
  String? noIjasah;
  String? tglIjasah;
  String? dokIjasah;
  String? sertKompetensi;
  String? tglSertKompetensi;
  String? dokSertKompetensi;
  String? strNo;
  String? strBerlaku;
  String? strTanggal;
  String? strAsal;
  String? dokStr;
  String? rekomOp;
  String? tglRekomOp;
  String? dokRekomOp;
  String? nim;
  String? dokNim;
  String? lembaga;
  String? fakultas;
  String? jurusan;
  int? revisi;
  String? ketRevisi;
  String? email;
  DateTime? emailVerifiedAt;
  String? password;
  String? rememberToken;
  int? hapus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? petugasCreate;
  int? petugasUpdate;
  String? ket;

  factory UserModels.fromJson(Map<String, dynamic> json) => UserModels(
        id: json["id"],
        uid: json["uid"],
        smartId: json["smart_id"],
        idVendor: json["id_vendor"],
        vendor: json["vendor"],
        jenis: json["jenis"],
        idNpwpd: json["id_npwpd"],
        nama: json["nama"],
        gelarDepan: json["gelar_depan"],
        gelarBelakang: json["gelar_belakang"],
        alamat: json["alamat"],
        dusun: json["dusun"],
        rt: json["rt"],
        rw: json["rw"],
        noProp: json["NO_PROP"],
        noKab: json["NO_KAB"],
        noKec: json["NO_KEC"],
        noKel: json["NO_KEL"],
        kelurahan: json["kelurahan"],
        kecamatan: json["kecamatan"],
        kota: json["kota"],
        propinsi: json["propinsi"],
        kodepos: json["kodepos"],
        lat: json["lat"],
        lng: json["lng"],
        nik: json["nik"],
        verifNik: json["verif_nik"],
        paspor: json["paspor"],
        kk: json["kk"],
        npwp: json["npwp"],
        npwpd: json["npwpd"],
        npwpdValid: json["npwpd_valid"],
        idNpwpdEpad: json["id_npwpd_epad"],
        tempLahir: json["temp_lahir"],
        tglLahir: json["tgl_lahir"],
        pekerjaan: json["pekerjaan"],
        telp: json["telp"],
        hp: json["hp"],
        hp1: json["hp1"],
        whatsapp: json["whatsapp"],
        foto: json["foto"],
        dokKtp: json["dok_ktp"],
        dokPaspor: json["dok_paspor"],
        dokKk: json["dok_kk"],
        dokNpwp: json["dok_npwp"],
        dokNpwpd: json["dok_npwpd"],
        kelamin: json["kelamin"],
        jenisKelamin: json["kelamin"] == 1 ? "LAKI-LAKI" : "PEREMPUAN",
        warganegara: json["warganegara"],
        jenisWarganegara: json["warganegara"] == 1 ? "INDONESIA" : "ASING",
        negara: json["negara"],
        idBadan: json["id_badan"],
        namaBadan: json["nama_badan"],
        alamatBadan: json["alamat_badan"],
        dusunBadan: json["dusun_badan"],
        rtBadan: json["rt_badan"],
        rwBadan: json["rw_badan"],
        noPropBadan: json["NO_PROP_BADAN"],
        noKabBadan: json["NO_KAB_BADAN"],
        noKecBadan: json["NO_KEC_BADAN"],
        noKelBadan: json["NO_KEL_BADAN"],
        kelurahanBadan: json["kelurahan_badan"],
        kecamatanBadan: json["kecamatan_badan"],
        kotaBadan: json["kota_badan"],
        propinsiBadan: json["propinsi_badan"],
        kodeposBadan: json["kodepos_badan"],
        telpBadan: json["telp_badan"],
        faxBadan: json["fax_badan"],
        skBadan: json["sk_badan"],
        ahuBadan: json["ahu_badan"],
        jabatan: json["jabatan"],
        kopSurat: json["kop_surat"],
        nib: json["nib"],
        dokAkta: json["dok_akta"],
        dokAhu: json["dok_ahu"],
        dokNib: json["dok_nib"],
        pendidikanTerakhir: json["pendidikan_terakhir"],
        lembagaPendidikan: json["lembaga_pendidikan"],
        noIjasah: json["no_ijasah"],
        tglIjasah: json["tgl_ijasah"],
        dokIjasah: json["dok_ijasah"],
        sertKompetensi: json["sert_kompetensi"],
        tglSertKompetensi: json["tgl_sert_kompetensi"],
        dokSertKompetensi: json["dok_sert_kompetensi"],
        strNo: json["str_no"],
        strBerlaku: json["str_berlaku"],
        strTanggal: json["str_tanggal"],
        strAsal: json["str_asal"],
        dokStr: json["dok_str"],
        rekomOp: json["rekom_op"],
        tglRekomOp: json["tgl_rekom_op"],
        dokRekomOp: json["dok_rekom_op"],
        nim: json["nim"],
        dokNim: json["dok_nim"],
        lembaga: json["lembaga"],
        fakultas: json["fakultas"],
        jurusan: json["jurusan"],
        revisi: json["revisi"],
        ketRevisi: json["ket_revisi"],
        email: json["email"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        password: json["password"],
        rememberToken: json["remember_token"],
        hapus: json["hapus"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        petugasCreate: json["petugas_create"],
        petugasUpdate: json["petugas_update"],
        ket: json["KET"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "smart_id": smartId,
        "id_vendor": idVendor,
        "vendor": vendor,
        "jenis": jenis,
        "id_npwpd": idNpwpd,
        "nama": nama,
        "gelar_depan": gelarDepan,
        "gelar_belakang": gelarBelakang,
        "alamat": alamat,
        "dusun": dusun,
        "rt": rt,
        "rw": rw,
        "NO_PROP": noProp,
        "NO_KAB": noKab,
        "NO_KEC": noKec,
        "NO_KEL": noKel,
        "kelurahan": kelurahan,
        "kecamatan": kecamatan,
        "kota": kota,
        "propinsi": propinsi,
        "kodepos": kodepos,
        "lat": lat,
        "lng": lng,
        "nik": nik,
        "verif_nik": verifNik,
        "paspor": paspor,
        "kk": kk,
        "npwp": npwp,
        "npwpd": npwpd,
        "npwpd_valid": npwpdValid,
        "id_npwpd_epad": idNpwpdEpad,
        "temp_lahir": tempLahir,
        "tgl_lahir": tglLahir,
        "pekerjaan": pekerjaan,
        "telp": telp,
        "hp": hp,
        "hp1": hp1,
        "whatsapp": whatsapp,
        "foto": foto,
        "dok_ktp": dokKtp,
        "dok_paspor": dokPaspor,
        "dok_kk": dokKk,
        "dok_npwp": dokNpwp,
        "dok_npwpd": dokNpwpd,
        "kelamin": kelamin,
        "warganegara": warganegara,
        "negara": negara,
        "id_badan": idBadan,
        "nama_badan": namaBadan,
        "alamat_badan": alamatBadan,
        "dusun_badan": dusunBadan,
        "rt_badan": rtBadan,
        "rw_badan": rwBadan,
        "NO_PROP_BADAN": noPropBadan,
        "NO_KAB_BADAN": noKabBadan,
        "NO_KEC_BADAN": noKecBadan,
        "NO_KEL_BADAN": noKelBadan,
        "kelurahan_badan": kelurahanBadan,
        "kecamatan_badan": kecamatanBadan,
        "kota_badan": kotaBadan,
        "propinsi_badan": propinsiBadan,
        "kodepos_badan": kodeposBadan,
        "telp_badan": telpBadan,
        "fax_badan": faxBadan,
        "sk_badan": skBadan,
        "ahu_badan": ahuBadan,
        "jabatan": jabatan,
        "kop_surat": kopSurat,
        "nib": nib,
        "dok_akta": dokAkta,
        "dok_ahu": dokAhu,
        "dok_nib": dokNib,
        "pendidikan_terakhir": pendidikanTerakhir,
        "lembaga_pendidikan": lembagaPendidikan,
        "no_ijasah": noIjasah,
        "tgl_ijasah": tglIjasah,
        "dok_ijasah": dokIjasah,
        "sert_kompetensi": sertKompetensi,
        "tgl_sert_kompetensi": tglSertKompetensi,
        "dok_sert_kompetensi": dokSertKompetensi,
        "str_no": strNo,
        "str_berlaku": strBerlaku,
        "str_tanggal": strTanggal,
        "str_asal": strAsal,
        "dok_str": dokStr,
        "rekom_op": rekomOp,
        "tgl_rekom_op": tglRekomOp,
        "dok_rekom_op": dokRekomOp,
        "nim": nim,
        "dok_nim": dokNim,
        "lembaga": lembaga,
        "fakultas": fakultas,
        "jurusan": jurusan,
        "revisi": revisi,
        "ket_revisi": ketRevisi,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "password": password,
        "remember_token": rememberToken,
        "hapus": hapus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "petugas_create": petugasCreate,
        "petugas_update": petugasUpdate,
        "KET": ket,
      };
}
