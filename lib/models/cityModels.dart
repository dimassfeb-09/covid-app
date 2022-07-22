// To parse this JSON data, do
//
//     final cityModels = cityModelsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CityModels cityModelsFromJson(String str) =>
    CityModels.fromJson(json.decode(str));

String cityModelsToJson(CityModels data) => json.encode(data.toJson());

class CityModels {
  CityModels({
    required this.key,
    required this.value,
  });

  String key;
  String value;

  factory CityModels.fromJson(Map<String, dynamic> json) => CityModels(
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
