// To parse this JSON data, do
//
//     final smartModels = smartModelsFromJson(jsonString);

import 'dart:convert';

List<SmartModels> smartModelsFromJson(String str) => List<SmartModels>.from(
    json.decode(str).map((x) => SmartModels.fromJson(x)));

String smartModelsToJson(List<SmartModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SmartModels {
  SmartModels({
    this.id,
    this.nama,
    this.nik,
    this.alamat,
    this.email,
    this.fcmId,
    this.foto,
    this.ktp,
    this.hp,
    this.pekerjaan,
  });

  String? id;
  String? nama;
  String? nik;
  String? alamat;
  String? email;
  String? fcmId;
  String? foto;
  String? ktp;
  String? hp;
  String? pekerjaan;

  factory SmartModels.fromJson(Map<String, dynamic> json) => SmartModels(
        id: json["id"],
        nama: json["nama"],
        nik: json["nik"],
        alamat: json["alamat"],
        email: json["email"],
        fcmId: json["fcmId"],
        foto: json["foto"],
        ktp: json["ktp"],
        hp: json["hp"],
        pekerjaan: json["pekerjaan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "nik": nik,
        "alamat": alamat,
        "email": email,
        "fcmId": fcmId,
        "foto": foto,
        "ktp": ktp,
        "hp": hp,
        "pekerjaan": pekerjaan,
      };
}
