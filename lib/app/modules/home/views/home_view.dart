import 'dart:convert';

import 'package:covid/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

import 'package:http/http.dart' as http;

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Color(0xFF5C42DC),
      ),
      body: ListView(
        children: [
          HeaderAppBar(),
          UpdateTerkini(),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              height: 87,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/card-jadipahlawan.png"),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, right: 16, left: 16),
            child: Text(
              "Layanan Fight Covid-19",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 16, left: 16, bottom: 20, top: 11),
            height: 189,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ContainerFightCovid(tipe: 'RS'),
                    ContainerFightCovid(tipe: 'Edukasi'),
                    ContainerFightCovid(tipe: 'Hotline'),
                    ContainerFightCovid(tipe: 'Internasional'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UpdateTerkini extends StatefulWidget {
  UpdateTerkini({Key? key}) : super(key: key);

  @override
  State<UpdateTerkini> createState() => _UpdateTerkiniState();
}

class _UpdateTerkiniState extends State<UpdateTerkini> {
  @override
  Future getData() async {
    Uri url = Uri.parse("https://data.covid19.go.id/public/api/update.json");
    var response = await http.get(url);

    var decode = jsonDecode(response.body)['update']['penambahan'];

    return decode;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Container(
        height: 136,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Update Terkini",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(DateTime.now().toString()),
              ],
            ),
            SizedBox(height: 12),
            FutureBuilder(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF5C42DC),
                      backgroundColor: Color(0xAA5C42DC),
                    ),
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 107,
                        width: 102,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 0.5,
                            color: Colors.grey,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image(
                              image: AssetImage("assets/images/positif.png"),
                              height: 26,
                              width: 26,
                            ),
                            Text(
                              snapshot.data['jumlah_positif'].toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF6045E2),
                              ),
                            ),
                            Text("Positif", style: TextStyle(fontSize: 10)),
                          ],
                        ),
                      ),
                      Container(
                        height: 107,
                        width: 102,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 0.5,
                            color: Colors.grey,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image(
                              image: AssetImage("assets/images/sembuh.png"),
                              height: 26,
                              width: 26,
                            ),
                            Text(
                              snapshot.data['jumlah_sembuh'].toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2ECC71),
                              ),
                            ),
                            Text("Sembuh", style: TextStyle(fontSize: 10)),
                          ],
                        ),
                      ),
                      Container(
                        height: 107,
                        width: 102,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 0.5,
                            color: Colors.grey,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image(
                              image: AssetImage("assets/images/meninggal.png"),
                              height: 26,
                              width: 26,
                            ),
                            Text(
                              snapshot.data['jumlah_meninggal'].toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFF1800),
                              ),
                            ),
                            Text("Meninggal", style: TextStyle(fontSize: 10)),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderAppBar extends StatelessWidget {
  const HeaderAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
      height: 90,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/header-appbar.png"),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fight Covid-19",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Ayo lawan Covid-19 di Indonesia bersama",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              InkWell(
                splashColor: Colors.grey,
                child: Image(
                  image: AssetImage("assets/images/icon-notification.png"),
                  height: 24,
                  width: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ContainerFightCovid extends StatelessWidget {
  HomeController homeController = HomeController();

  String tipe;

  ContainerFightCovid({required this.tipe});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed("/${homeController.menuLayanan(tipe: tipe)['page']}");
      },
      child: Container(
        height: 100,
        width: 74,
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFC4BDE3).withOpacity(0.5),
              offset: Offset(1, 5),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage(homeController.menuLayanan(tipe: tipe)['logo']),
              width: 35,
              height: 35,
            ),
            Text(
              homeController.menuLayanan(tipe: tipe)['title'],
              style: TextStyle(
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
