import 'dart:convert';

AnggotaSkpModels anggotaSkpModelsFromJson(String str) =>
    AnggotaSkpModels.fromJson(json.decode(str));

String anggotaSkpModelsToJson(AnggotaSkpModels data) =>
    json.encode(data.toJson());

class AnggotaSkpModels {
  AnggotaSkpModels({
    this.nama,
    this.alamat,
  });

  String? nama;
  String? alamat;

  factory AnggotaSkpModels.fromJson(Map<String, dynamic> json) =>
      AnggotaSkpModels(
        nama: json["nama"],
        alamat: json["alamat"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "alamat": alamat,
      };
}
