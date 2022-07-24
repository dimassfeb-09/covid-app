import 'dart:convert';

import 'package:covid/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
          PahlawanCovid(),
          LayananFightCovid19(),
        ],
      ),
    );
  }
}

class UpdateTerkini extends StatelessWidget {
  @override
  HomeController homeController = HomeController();

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
                Text(DateFormat.yMMMMd().format(DateTime.now())),
              ],
            ),
            SizedBox(height: 12),
            FutureBuilder(
              future: homeController.getData(),
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

class PahlawanCovid extends StatelessWidget {
  const PahlawanCovid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
    );
  }
}

class LayananFightCovid19 extends StatelessWidget {
  Map menu = {
    "RS": {
      "Route": Routes.RUJUKAN,
      "title": "RS Rujukan",
      "logo": "assets/images/LayananCovid/rumah-sakit.png",
    },
    "HOTLINE": {
      "Route": Routes.HOTLINE,
      "title": "Hotline",
      "logo": "assets/images/LayananCovid/hotline.png",
    },
    "INTERNASIONAL": {
      "Route": Routes.INTERNASIONAL,
      "title": "Data \nInternasional",
      "logo": "assets/images/LayananCovid/data-internasional.png",
    },
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 16, left: 16, bottom: 20, top: 20),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Layanan Fight Covid-19",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(menu['RS']['Route']);
                    },
                    borderRadius: BorderRadius.circular(10),
                    splashColor: Color(0xFF794EE0).withOpacity(0.25),
                    highlightColor: Color(0xFF794EE0).withOpacity(0.5),
                    child: Ink(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(1, 1),
                            blurRadius: 10,
                            color: Color(0xFFC4BDE3),
                          ),
                        ],
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image(
                            image: AssetImage(
                              menu['RS']['logo'],
                            ),
                            height: 36,
                            width: 36,
                          ),
                          Text(
                            menu['RS']['title'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(menu['HOTLINE']['Route']);
                    },
                    borderRadius: BorderRadius.circular(10),
                    splashColor: Color(0xFF794EE0).withOpacity(0.25),
                    highlightColor: Color(0xFF794EE0).withOpacity(0.5),
                    child: Ink(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(1, 1),
                            blurRadius: 10,
                            color: Color(0xaaC4BDE3),
                          ),
                        ],
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image(
                            image: AssetImage(
                              menu['HOTLINE']['logo'],
                            ),
                            height: 36,
                            width: 36,
                          ),
                          Text(
                            menu['HOTLINE']['title'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(
                        menu['INTERNASIONAL']['Route'],
                      );
                    },
                    borderRadius: BorderRadius.circular(10),
                    splashColor: Color(0xFF794EE0).withOpacity(0.25),
                    highlightColor: Color(0xFF794EE0).withOpacity(0.5),
                    child: Ink(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(1, 1),
                            blurRadius: 10,
                            color: Color(0xaaC4BDE3),
                          ),
                        ],
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image(
                            image: AssetImage(
                              menu['INTERNASIONAL']['logo'],
                            ),
                            height: 36,
                            width: 36,
                          ),
                          Text(
                            menu['INTERNASIONAL']['title'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
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
