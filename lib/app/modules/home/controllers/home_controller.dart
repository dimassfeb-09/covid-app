import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

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
