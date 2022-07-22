// To parse this JSON data, do
//
//     final dataRsModels = dataRsModelsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DataRsModels dataRsModelsFromJson(String str) =>
    DataRsModels.fromJson(json.decode(str));

String dataRsModelsToJson(DataRsModels data) => json.encode(data.toJson());

class DataRsModels {
  DataRsModels({
    required this.id,
    required this.kode,
    required this.nama,
    required this.alamat,
    required this.kota,
    required this.provinsi,
  });

  int id;
  String kode;
  String nama;
  String alamat;
  String kota;
  String provinsi;

  factory DataRsModels.fromJson(Map<String, dynamic> json) => DataRsModels(
        id: json["id"],
        kode: json["kode"],
        nama: json["nama"],
        alamat: json["alamat"],
        kota: json["kota"],
        provinsi: json["provinsi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode": kode,
        "nama": nama,
        "alamat": alamat,
        "kota": kota,
        "provinsi": provinsi,
      };
}
