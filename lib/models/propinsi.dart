// To parse this JSON data, do
//
//     final propinsiModels = propinsiModelsFromJson(jsonString);

import 'dart:convert';

PropinsiModels propinsiModelsFromJson(String str) =>
    PropinsiModels.fromJson(json.decode(str));

String propinsiModelsToJson(PropinsiModels data) => json.encode(data.toJson());

class PropinsiModels {
  PropinsiModels({
    this.noProp,
    this.namaProp,
  });

  String? noProp;
  String? namaProp;

  factory PropinsiModels.fromJson(Map<String, dynamic> json) => PropinsiModels(
        noProp: json["NO_PROP"],
        namaProp: json["NAMA_PROP"],
      );

  Map<String, dynamic> toJson() => {
        "NO_PROP": noProp,
        "NAMA_PROP": namaProp,
      };
}
