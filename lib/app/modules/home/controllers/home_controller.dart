import 'dart:convert';

import 'package:covid/models/dataCovidIndonesiaModels.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  Future getData() async {
    Uri url = Uri.parse("https://data.covid19.go.id/public/api/update.json");
    var response = await http.get(url);

    var decode = jsonDecode(response.body)['update']['penambahan'];

    return decode;
  }

  menuLayanan({required String tipe}) {
    Map mapData = {
      "RS": {
        "title": "Rujukan Rumah Sakit",
        "logo": "assets/images/LayananCovid/rumah-sakit.png",
        "page": "rujukan",
      },
      "Edukasi": {
        "title": "Edukasi Covid-19",
        "logo": "assets/images/LayananCovid/edukasi-covid.png",
        "page": "edukasi",
      },
      "Hotline": {
        "title": "Hotline",
        "logo": "assets/images/LayananCovid/hotline.png",
        "page": "hotline",
      },
      "Internasional": {
        "title": "Data Internasional",
        "logo": "assets/images/LayananCovid/data-internasional.png",
        "page": "internasional",
      },
    };

    String title = mapData[tipe]['title'];
    String logo = mapData[tipe]['logo'];
    var page = mapData[tipe]['page'];

    return {"title": title, "logo": logo, "page": page};
  }
}
