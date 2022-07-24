import 'dart:convert';

import 'package:covid/models/cityModels.dart';
import 'package:covid/models/dataRsModels.dart';
import 'package:covid/models/provinceModels.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class RujukanController extends GetxController {
  //TODO: Implement RujukanController

  RxString province_id = '0'.obs;
  RxString city_id = '0'.obs;

  RxMap detailRs = {}.obs;
  RxBool renderDetailRs = false.obs;

  Future<List<ProvinceModels>> postDataProvince() async {
    try {
      Uri url = Uri.parse("https://kipi.covid19.go.id/api/get-province");
      var response = await http.post(url);

      List<ProvinceModels> provinceData = [];

      List fetchData =
          (jsonDecode(response.body) as Map<String, dynamic>)['results'];

      fetchData.forEach((element) {
        provinceData.add(ProvinceModels.fromJson(element));
      });

      return provinceData;
    } catch (e) {
      print("Get Provinsi Model Gagal");
      print(e);
      return [];
    }
  }

  Future<List<CityModels>> postDataCity() async {
    try {
      Uri url = Uri.parse(
          "https://kipi.covid19.go.id/api/get-city?start_id=$province_id");
      var response = await http.post(url);

      List<CityModels> provinceData = [];

      List fetchData =
          (jsonDecode(response.body) as Map<String, dynamic>)['results'];

      fetchData.forEach((element) {
        provinceData.add(CityModels.fromJson(element));
      });

      return provinceData;
    } catch (e) {
      print("Get Kota Model Gagal");
      print(e);
      return [];
    }
  }

  Future<List<DataRsModels>> getDataRs() async {
    try {
      Uri url = Uri.parse(
        "https://kipi.covid19.go.id/api/get-faskes-vaksinasi?city=${city_id.value}",
      );
      var response = await http.get(url);

      List<DataRsModels> dataRs = [];

      List fetchData =
          (jsonDecode(response.body) as Map<String, dynamic>)['data'];

      for (var value in fetchData) {
        dataRs.add(DataRsModels.fromJson(value));
      }

      return dataRs;
    } catch (e) {
      print("Get Data RS Model Gagal");
      print(e);
      return [];
    }
  }
}
