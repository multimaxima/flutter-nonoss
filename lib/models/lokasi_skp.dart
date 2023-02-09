import 'dart:convert';

LokasiSkpModels lokasiSkpModelsFromJson(String str) =>
    LokasiSkpModels.fromJson(json.decode(str));

String lokasiSkpModelsToJson(LokasiSkpModels data) =>
    json.encode(data.toJson());

class LokasiSkpModels {
  LokasiSkpModels({
    this.pimpinan,
    this.lokasi,
  });

  String? pimpinan;
  String? lokasi;

  factory LokasiSkpModels.fromJson(Map<String, dynamic> json) =>
      LokasiSkpModels(
        pimpinan: json["pimpinan"],
        lokasi: json["lokasi"],
      );

  Map<String, dynamic> toJson() => {
        "pimpinan": pimpinan,
        "lokasi": lokasi,
      };
}
