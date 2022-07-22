// To parse this JSON data, do
//
//     final provinceModels = provinceModelsFromJson(jsonString);

import 'dart:convert';

ProvinceModels provinceModelsFromJson(String str) =>
    ProvinceModels.fromJson(json.decode(str));

String provinceModelsToJson(ProvinceModels data) => json.encode(data.toJson());

class ProvinceModels {
  ProvinceModels({
    required this.key,
    required this.value,
  });

  String key;
  String value;

  factory ProvinceModels.fromJson(Map<String, dynamic> json) => ProvinceModels(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };

  @override
  String toString() => value;
}
