import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:covid/models/dataRsModels.dart';
import 'package:flutter/gestures.dart';

import '../../../../models/cityModels.dart';
import '../../../../models/provinceModels.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';
import 'package:http/retry.dart';

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

class RsRujukan extends StatefulWidget {
  @override
  State<RsRujukan> createState() => _RsRujukanState();
}

bool isRsSelected = false;

String keyProvince = "0";
String keyCity = "0";

RxMap detailRs = {
  'id': 0,
  'nama': '',
  'alamat': '',
  'kota': '',
  'provinsi': '',
}.obs;

class _RsRujukanState extends State<RsRujukan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      child: ListView(
        children: [
          DropdownSearch<ProvinceModels>(
            onChanged: (value) async {
              keyProvince = value!.key;
            },
            asyncItems: (text) async {
              try {
                Uri url =
                    Uri.parse("https://kipi.covid19.go.id/api/get-province");
                var response = await http.post(url);

                List data = jsonDecode(response.body)['results'];

                List<ProvinceModels> allProvinceModels = [];

                data.forEach((element) {
                  allProvinceModels.add(
                    ProvinceModels(
                      key: element['key'],
                      value: element['value'],
                    ),
                  );
                });

                return allProvinceModels;
              } catch (e) {
                print(e);
                print("PROVINSI ERROR");
                return [];
              }
            },
            onBeforeChange: (prevItem, nextItem) async {
              keyProvince = nextItem!.value;

              setState(() {
                isRsSelected = false;
              });

              return true;
            },
            dropdownBuilder: (context, selectedItem) =>
                Text(selectedItem?.value ?? 'Pilih Provinsi'),
            clearButtonProps: ClearButtonProps(),
            popupProps: PopupProps.menu(
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              itemBuilder: (context, item, isSelected) {
                return ListTile(
                  leading: Text(item.value),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          DropdownSearch<CityModels>(
            onChanged: (value) {
              keyCity = value!.key;
            },
            asyncItems: (text) async {
              Uri url = Uri.parse(
                  "https://kipi.covid19.go.id/api/get-city?start_id=$keyProvince");
              var response = await http.post(url);

              List data = jsonDecode(response.body)['results'];

              List<CityModels> allCityModels = [];

              data.forEach((element) {
                allCityModels.add(
                  CityModels(
                    key: element['key'],
                    value: element['value'],
                  ),
                );
              });

              return allCityModels;
            },
            onBeforeChange: (prevItem, nextItem) async {
              keyCity = nextItem!.value;

              return true;
            },
            dropdownBuilder: (context, selectedItem) {
              return Text(selectedItem?.value ?? 'Pilih Kota');
            },
            clearButtonProps: ClearButtonProps(),
            popupProps: PopupProps.menu(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                leading: Text(
                  item.value,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          DropdownSearch<DataRsModels>(
            onChanged: (value) async {
              Uri url = Uri.parse(
                  "https://kipi.covid19.go.id/api/get-faskes-vaksinasi?province=$keyProvince&city=$keyCity");
              var response = await http.get(url);

              List data = jsonDecode(response.body)['data'];

              List<DataRsModels> dataRsModel = [];

              data.forEach((element) {
                dataRsModel.add(
                  DataRsModels.fromJson(element),
                );
              });
            },
            onBeforeChange: (prevItem, nextItem) async {
              setState(() {
                isRsSelected = true;
                detailRs.value['id'] = nextItem?.id;
                detailRs.value['nama'] = nextItem?.nama;
                detailRs.value['alamat'] = nextItem?.alamat;
                detailRs.value['kota'] = nextItem?.kota;
                detailRs.value['provinsi'] = nextItem?.provinsi;
              });

              print(detailRs['nama']);

              return true;
            },
            asyncItems: (text) async {
              Uri url = Uri.parse(
                  "https://kipi.covid19.go.id/api/get-faskes-vaksinasi?province=$keyProvince&city=$keyCity");
              var response = await http.get(url);

              List data = jsonDecode(response.body)['data'];

              List<DataRsModels> dataRsModel = [];

              data.forEach((element) {
                dataRsModel.add(
                  DataRsModels.fromJson(element),
                );
              });

              return dataRsModel;
            },
            dropdownBuilder: (context, selectedItem) {
              return Text(selectedItem?.nama ?? 'Pilih Faskes');
            },
            clearButtonProps: ClearButtonProps(),
            popupProps: PopupProps.menu(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                leading: Text(
                  item.nama,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          if (isRsSelected == true)
            Container(
              height: 1000,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFF6045E2),
                      borderRadius: BorderRadius.circular(10),
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
                  DetailRsWidget(label: 'Nama', value: detailRs['nama']),
                  DetailRsWidget(label: 'Alamat', value: detailRs['alamat']),
                  DetailRsWidget(label: 'Kota', value: detailRs['kota']),
                  DetailRsWidget(
                      label: 'Provinsi', value: detailRs['provinsi']),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class DetailRsWidget extends StatelessWidget {
  String label;
  String value;

  DetailRsWidget({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 25,
          width: 70,
          decoration: BoxDecoration(
            color: Color(0xFF6045E2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 70,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Text(
            value,
            maxLines: 5,
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
