// To parse this JSON data, do
//
//     final dataCovidIndonesiaModel = dataCovidIndonesiaModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DataCovidIndonesiaModel dataCovidIndonesiaModelFromJson(String str) =>
    DataCovidIndonesiaModel.fromJson(json.decode(str));

String dataCovidIndonesiaModelToJson(DataCovidIndonesiaModel data) =>
    json.encode(data.toJson());

class DataCovidIndonesiaModel {
  DataCovidIndonesiaModel({
    required this.jumlahPositif,
    required this.jumlahMeninggal,
    required this.jumlahSembuh,
    required this.jumlahDirawat,
    required this.tanggal,
    required this.created,
  });

  int jumlahPositif;
  int jumlahMeninggal;
  int jumlahSembuh;
  int jumlahDirawat;
  DateTime tanggal;
  DateTime created;

  factory DataCovidIndonesiaModel.fromJson(Map<String, dynamic> json) =>
      DataCovidIndonesiaModel(
        jumlahPositif: json["jumlah_positif"],
        jumlahMeninggal: json["jumlah_meninggal"],
        jumlahSembuh: json["jumlah_sembuh"],
        jumlahDirawat: json["jumlah_dirawat"],
        tanggal: DateTime.parse(json["tanggal"]),
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "jumlah_positif": jumlahPositif,
        "jumlah_meninggal": jumlahMeninggal,
        "jumlah_sembuh": jumlahSembuh,
        "jumlah_dirawat": jumlahDirawat,
        "tanggal":
            "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "created": created.toIso8601String(),
      };
}
