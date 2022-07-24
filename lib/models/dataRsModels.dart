// To parse this JSON data, do
//
//     final dataRsModels = dataRsModelsFromJson(jsonString);

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
    required this.latitude,
    required this.longitude,
    required this.telp,
  });

  int? id;
  String? kode;
  String? nama;
  String? alamat;
  String? kota;
  String? provinsi;
  String? latitude;
  String? longitude;
  String? telp;

  factory DataRsModels.fromJson(Map<String, dynamic> json) => DataRsModels(
        id: json["id"],
        kode: json["kode"],
        nama: json["nama"],
        alamat: json["alamat"],
        kota: json["kota"],
        provinsi: json["provinsi"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        telp: json["telp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode": kode,
        "nama": nama,
        "alamat": alamat,
        "kota": kota,
        "provinsi": provinsi,
        "latitude": latitude,
        "longitude": longitude,
        "telp": telp,
      };

  @override
  String toString() => nama!;
}
