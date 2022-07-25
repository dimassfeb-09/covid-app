import 'dart:convert';

import 'package:card_loading/card_loading.dart';
import 'package:covid/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeController homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    List<Widget> _selectScreen = [
      ListView(
        children: [
          HeaderAppBar(),
          UpdateTerkini(),
          PahlawanCovid(),
          LayananFightCovid19(),
          BeritaCovid(homeController: homeController),
        ],
      ),
      MenuProfile(),
    ];

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: Color(0xFF5C42DC),
        ),
        body: _selectScreen.elementAt(homeController.selectedIndex.value),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            homeController.selectedIndex.value = value;
          },
          currentIndex: homeController.selectedIndex.value,
          selectedItemColor: Color(0xFF5C42DC),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color(0xFF5C42DC),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Color(0xFF5C42DC),
            ),
          ],
        ),
      ),
    );
  }
}

class BeritaCovid extends StatelessWidget {
  const BeritaCovid({
    Key? key,
    required this.homeController,
  }) : super(key: key);

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Berita Covid",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          FutureBuilder(
            future: homeController.getDataNews(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Container(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int index) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        children: [
                          Column(
                            children: [
                              CardLoading(
                                height: 150,
                                width: 300,
                                margin: EdgeInsets.only(right: 20, top: 20),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              SizedBox(height: 10),
                              CardLoading(
                                height: 20,
                                width: 300,
                                margin: EdgeInsets.only(right: 20),
                                borderRadius: BorderRadius.circular(10),
                              )
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Uri url =
                                  Uri.parse("${snapshot.data[index]['url']}");
                              launchUrl(url);
                            },
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 20, top: 20),
                                  height: 150,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "${snapshot.data[index]['urlToImage']}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  margin: EdgeInsets.only(right: 20),
                                  width: 300,
                                  height: 30,
                                  child: Text(
                                    "${snapshot.data[index]['title']}",
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                  },
                ),
              );
            },
          ),
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
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CardLoading(height: 107, width: 102),
                      CardLoading(height: 107, width: 102),
                      CardLoading(height: 107, width: 102),
                    ],
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

class MenuProfile extends StatelessWidget {
  const MenuProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text("Profile Menu"),
          centerTitle: true,
          backgroundColor: Color(0xFF5C42DC),
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("App Version"),
                  Text("v1.0"),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Name App"),
                  Text("Covid App"),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Author App by"),
                  InkWell(
                    onTap: () {
                      launchUrl(
                          Uri.parse("https://www.instagram.com/dimassfeb"));
                    },
                    child: Row(
                      children: [
                        Text(
                          "Dimas Febriyanto",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.open_in_new),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Design App by"),
                  InkWell(
                    onTap: () {
                      launchUrl(Uri.parse(
                          "https://www.figma.com/community/file/849809659468946971"));
                    },
                    child: Row(
                      children: [
                        Text(
                          "Nanda Febrian Adhinugroho",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.open_in_new),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Last Updated"),
                  Text("24 Jul 2022"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
