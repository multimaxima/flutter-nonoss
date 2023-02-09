// To parse this JSON data, do
//
//     final fasyankesModels = fasyankesModelsFromJson(jsonString);

import 'dart:convert';

FasyankesModels fasyankesModelsFromJson(String str) =>
    FasyankesModels.fromJson(json.decode(str));

String fasyankesModelsToJson(FasyankesModels data) =>
    json.encode(data.toJson());

class FasyankesModels {
  FasyankesModels({
    this.id,
    this.idKategori,
    this.nama,
    this.alamat,
    this.dusun,
    this.rt,
    this.rw,
    this.noProp,
    this.noKab,
    this.noKec,
    this.noKel,
    this.desa,
    this.kecamatan,
    this.kota,
    this.propinsi,
    this.kodepos,
    this.lat,
    this.lng,
    this.telp,
    this.fax,
    this.email,
    this.web,
    this.kontak,
    this.hp,
    this.whatsapp,
    this.foto,
    this.createdAt,
    this.updatedAt,
    this.petugasCreate,
    this.petugasUpdate,
    this.idJenis,
  });

  int? id;
  int? idKategori;
  String? nama;
  String? alamat;
  String? dusun;
  String? rt;
  String? rw;
  String? noProp;
  String? noKab;
  String? noKec;
  String? noKel;
  String? desa;
  String? kecamatan;
  String? kota;
  String? propinsi;
  String? kodepos;
  String? lat;
  String? lng;
  String? telp;
  String? fax;
  String? email;
  String? web;
  String? kontak;
  String? hp;
  String? whatsapp;
  String? foto;
  DateTime? createdAt;
  DateTime? updatedAt;
  BigInt? petugasCreate;
  BigInt? petugasUpdate;
  int? idJenis;

  factory FasyankesModels.fromJson(Map<String, dynamic> json) =>
      FasyankesModels(
        id: json["id"],
        idKategori: json["id_kategori"],
        nama: json["nama"],
        alamat: json["alamat"],
        dusun: json["dusun"],
        rt: json["rt"],
        rw: json["rw"],
        noProp: json["NO_PROP"],
        noKab: json["NO_KAB"],
        noKec: json["NO_KEC"],
        noKel: json["NO_KEL"],
        desa: json["desa"],
        kecamatan: json["kecamatan"],
        kota: json["kota"],
        propinsi: json["propinsi"],
        kodepos: json["kodepos"],
        lat: json["lat"],
        lng: json["lng"],
        telp: json["telp"],
        fax: json["fax"],
        email: json["email"],
        web: json["web"],
        kontak: json["kontak"],
        hp: json["hp"],
        whatsapp: json["whatsapp"],
        foto: json["foto"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        petugasCreate: json["petugas_create"],
        petugasUpdate: json["petugas_update"],
        idJenis: json["id_jenis"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_kategori": idKategori,
        "nama": nama,
        "alamat": alamat,
        "dusun": dusun,
        "rt": rt,
        "rw": rw,
        "NO_PROP": noProp,
        "NO_KAB": noKab,
        "NO_KEC": noKec,
        "NO_KEL": noKel,
        "desa": desa,
        "kecamatan": kecamatan,
        "kota": kota,
        "propinsi": propinsi,
        "kodepos": kodepos,
        "lat": lat,
        "lng": lng,
        "telp": telp,
        "fax": fax,
        "email": email,
        "web": web,
        "kontak": kontak,
        "hp": hp,
        "whatsapp": whatsapp,
        "foto": foto,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "petugas_create": petugasCreate,
        "petugas_update": petugasUpdate,
        "id_jenis": idJenis,
      };
}
