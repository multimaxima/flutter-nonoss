// To parse this JSON data, do
//
//     final ikmResultModels = ikmResultModelsFromJson(jsonString);

import 'dart:convert';

IkmResultModels ikmResultModelsFromJson(String str) => IkmResultModels.fromJson(json.decode(str));

String ikmResultModelsToJson(IkmResultModels data) => json.encode(data.toJson());

class IkmResultModels {
  IkmResultModels({
    this.id,
    this.score,
  });

  int? id;
  String? score;

  factory IkmResultModels.fromJson(Map<String, dynamic> json) => IkmResultModels(
        id: json["id"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "score": score,
      };
}
