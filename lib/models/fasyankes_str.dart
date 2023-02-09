// To parse this JSON data, do
//
//     final strModels = strModelsFromJson(jsonString);

import 'dart:convert';

StrModels strModelsFromJson(String str) => StrModels.fromJson(json.decode(str));

String strModelsToJson(StrModels data) => json.encode(data.toJson());

class StrModels {
  StrModels({
    required this.asal,
  });

  String asal;

  factory StrModels.fromJson(Map<String, dynamic> json) => StrModels(
        asal: json["asal"],
      );

  Map<String, dynamic> toJson() => {
        "asal": asal,
      };
}
