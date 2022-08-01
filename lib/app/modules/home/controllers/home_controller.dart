import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  RxInt selectedIndex = 0.obs;

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

  Future getDataNews() async {
    String apiKey = "pub_952662d529b70aafe95a868df873ad5b9ada";

    Uri url = Uri.parse(
        "https://newsapi.org/v2/everything?q=covid&apiKey=7735aaca160040e7a265b83222cae677");
    var response = await http.get(url);

    List fetchData = jsonDecode(response.body)['articles'];

    return fetchData;
  }
}
