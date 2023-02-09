// To parse this JSON data, do
//
//     final bentukBadanKkprModels = bentukBadanKkprModelsFromJson(jsonString);

import 'dart:convert';

BentukBadanKkprModels bentukBadanKkprModelsFromJson(String str) =>
    BentukBadanKkprModels.fromJson(json.decode(str));

String bentukBadanKkprModelsToJson(BentukBadanKkprModels data) =>
    json.encode(data.toJson());

class BentukBadanKkprModels {
  BentukBadanKkprModels({
    this.id,
    this.ket,
  });

  int? id;
  String? ket;

  factory BentukBadanKkprModels.fromJson(Map<String, dynamic> json) =>
      BentukBadanKkprModels(
        id: json["ID"],
        ket: json["KET"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "KET": ket,
      };
}
