// To parse this JSON data, do
//
//     final areaModels = areaModelsFromJson(jsonString);

import 'dart:convert';

AreaModels areaModelsFromJson(String str) =>
    AreaModels.fromJson(json.decode(str));

String areaModelsToJson(AreaModels data) => json.encode(data.toJson());

class AreaModels {
  AreaModels({
    this.id,
    this.area,
    this.zona,
    this.hapus,
  });

  int? id;
  String? area;
  String? zona;
  int? hapus;

  factory AreaModels.fromJson(Map<String, dynamic> json) => AreaModels(
        id: json["id"],
        area: json["area"],
        zona: json["zona"],
        hapus: json["hapus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "area": area,
        "zona": zona,
        "hapus": hapus,
      };
}
