import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MenuAbout extends StatelessWidget {
  const MenuAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text("About"),
          centerTitle: true,
          backgroundColor: Color(0xFF278BD8),
        ),
        SizedBox(height: 15),
        Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: const [
              AboutApplicationWidget(),
              CreditAppsWidget(),
            ],
          ),
        ),
      ],
    );
  }
}

class AboutApplicationWidget extends StatelessWidget {
  const AboutApplicationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.defaultDialog(
          title: "About Application",
          titleStyle: TextStyle(fontSize: 20),
          content: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Aplikasi Analisis Covid 19 Indonesia adalah aplikasi untuk mengetahui jumlah data dari seseorang yang terpapar Covid 19 di Indonesia dan Internasional",
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("App Version"),
                    Text("v1.0"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Author"),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            launchUrlString("https://instagram.com/dimassfeb");
                          },
                          child: Text("Dimas Febriyanto"),
                        ),
                        const Icon(
                          Icons.open_in_new,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Last Updated"),
                    Text("2 Aug 2021"),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      leading: Text("About Application"),
    );
  }
}

class CreditAppsWidget extends StatelessWidget {
  const CreditAppsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.defaultDialog(
          title: 'Credit Apps',
          titleStyle: TextStyle(fontSize: 20),
          content: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Credit ini diperuntukkan mencantumkan beberapa sumber yang digunakan pada aplikasi untuk mengembangkan Kreator",
                  textAlign: TextAlign.justify,
                ),
                GestureDetector(
                  onTap: () {
                    launchUrlString(
                        "https://www.flaticon.com/premium-icon/hospital_3658653");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Hospital Icon"),
                      Icon(Icons.open_in_new),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launchUrlString(
                        "https://www.flaticon.com/free-icon/hotline_6509307");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Hotline Icon"),
                      Icon(Icons.open_in_new),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launchUrlString(
                        "https://www.flaticon.com/premium-icon/data-analysis_4580275");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Data Analys Icon"),
                      Icon(Icons.open_in_new),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      leading: Text("Credit Apps"),
    );
  }
}
