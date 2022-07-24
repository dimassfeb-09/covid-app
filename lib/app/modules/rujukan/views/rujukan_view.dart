import 'dart:convert';
import 'package:covid/models/dataRsModels.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../models/cityModels.dart';
import '../../../../models/provinceModels.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rujukan_controller.dart';
import 'package:http/http.dart' as http;

class RujukanView extends GetView<RujukanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6045E2),
        elevation: 2,
        title: const Text(
          'Rumah Sakit Rujukan',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: RsRujukan(),
    );
  }
}

class RsRujukan extends StatelessWidget {
  RujukanController rujukanController = RujukanController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        DropdownSearch<ProvinceModels>(
          asyncItems: (text) {
            return rujukanController.postDataProvince();
          },
          onChanged: (value) {
            rujukanController.province_id.value = value!.value;
            print("Selected Province: " + value.key);
          },
          popupProps: PopupProps.menu(
            showSearchBox: true,
          ),
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Pilih Provinsi"),
            ),
          ),
        ),
        SizedBox(height: 20),
        DropdownSearch<CityModels>(
          asyncItems: (text) {
            return rujukanController.postDataCity();
          },
          onChanged: (value) {
            rujukanController.city_id.value = value!.value;

            print("Selected City: " + value.key);
          },
          popupProps: PopupProps.menu(
            showSearchBox: true,
          ),
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Pilih Kota"),
            ),
          ),
        ),
        SizedBox(height: 20),
        DropdownSearch<DataRsModels>(
          asyncItems: (text) {
            return rujukanController.getDataRs();
          },
          onBeforePopupOpening: (selectedItem) async {
            return true;
          },
          onBeforeChange: (prevItem, nextItem) async {
            rujukanController.renderDetailRs.value = true;
            return true;
          },
          onChanged: (value) {
            print("Selected RS: " + value!.nama!);

            rujukanController.detailRs.addAll({
              "id": value.id,
              "nama": value.nama,
              "alamat": value.alamat,
              "kota": value.kota,
              "provinsi": value.provinsi,
              "telp": value.telp,
              "location": {
                "latitude": value.latitude,
                "longitude": value.longitude,
              },
            });
          },
          popupProps: PopupProps.menu(
            showSearchBox: true,
          ),
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Pilih Rumah Sakit"),
            ),
          ),
        ),
        SizedBox(height: 20),
        Obx(
          () => Visibility(
            visible: rujukanController.renderDetailRs.value,
            child: Container(
              height: 400,
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFF6045E2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Detail RS",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Nama RS: "),
                      Text("${rujukanController.detailRs.value['nama']}"),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Alamat RS: "),
                      SizedBox(width: 30),
                      Expanded(
                        child: Container(
                          child: Text(
                            "${rujukanController.detailRs.value['alamat']}",
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Kota RS: "),
                      Text("${rujukanController.detailRs.value['kota']}"),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Provinsi RS: "),
                      Text("${rujukanController.detailRs.value['provinsi']}"),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      InkWell(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              height: 50,
                              width: 50,
                              child: Icon(Icons.map, color: Colors.white),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Text(
                              "Buka Map",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        focusColor: Colors.red,
                        onTap: () {
                          String lat = rujukanController
                              .detailRs.value['location']['latitude'];
                          String long = rujukanController
                              .detailRs.value['location']['longitude'];
                          Uri url = Uri.parse(
                              "https://maps.google.com/?q=$lat,$long");

                          launchUrl(url);
                        },
                      ),
                      SizedBox(width: 20),
                      InkWell(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              height: 50,
                              width: 50,
                              child: Icon(Icons.phone, color: Colors.white),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Text(
                              "Telepon",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        focusColor: Colors.red,
                        onTap: () {
                          Uri url = Uri.parse(
                              "tel:${rujukanController.detailRs.value['telp']}");

                          launchUrl(url);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
