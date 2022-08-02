import 'package:card_loading/card_loading.dart';
import 'package:covid/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/home_controller.dart';
import 'about_view.dart';

class HomeView extends GetView<HomeController> {
  HomeController homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    List<Widget> _selectScreen = [
      ListView(
        children: [
          Stack(
            children: [
              HeaderAppBar(),
            ],
          ),
          SafeArea(
            child: Column(
              children: [
                UpdateTerkini(),
                LayananFightCovid19(),
                BeritaCovid(homeController: homeController),
              ],
            ),
          ),
        ],
      ),
      MenuAbout(),
    ];

    return Obx(
      () => Scaffold(
        appBar: AppBar(elevation: 0, toolbarHeight: 0),
        body: _selectScreen.elementAt(homeController.selectedIndex.value),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            homeController.selectedIndex.value = value;
          },
          currentIndex: homeController.selectedIndex.value,
          selectedItemColor: Color(0xFF278BD8),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color(0xFF278BD8),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'About',
              backgroundColor: Color(0xFF278BD8),
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
      margin: EdgeInsets.only(left: 16, top: 20),
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
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: FutureBuilder(
        future: homeController.getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardLoading(
                      height: 20,
                      width: 100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    CardLoading(
                      height: 20,
                      width: 90,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Container(
                  child: Column(
                    children: [
                      // Data Positif, Sembuh Negatif
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CardLoading(
                            height: 110,
                            width: size.width * 0.29,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          CardLoading(
                            height: 110,
                            width: size.width * 0.29,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          CardLoading(
                            height: 110,
                            width: size.width * 0.29,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Chart
                      CardLoading(
                        height: 190,
                        width: size.width,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            int positif = snapshot.data['jumlah_positif'];
            int sembuh = snapshot.data['jumlah_sembuh'];
            int meninggal = snapshot.data['jumlah_meninggal'];

            late double positifData;
            late double sembuhData;
            late double meninggalData;

            positifData =
                100 - positif / (positif + sembuh + meninggal) * 1 * 100;
            sembuhData =
                100 - sembuh / (positif + sembuh + meninggal) * 1 * 100;
            meninggalData =
                100 - meninggal / (positif + sembuh + meninggal) * 1 * 100;

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Update Hari Ini",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(DateFormat.yMMMMd().format(DateTime.now())),
                  ],
                ),
                SizedBox(height: 12),
                Container(
                  child: Column(
                    children: [
                      // Data Positif, Sembuh Negatif
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 110,
                            width: size.width * 0.29,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.blue.withOpacity(0.5)),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  offset: Offset(1, 5),
                                  spreadRadius: -8,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image(
                                  image:
                                      AssetImage("assets/images/positif.png"),
                                  height: 25,
                                  width: 25,
                                ),
                                Text(
                                  snapshot.data['jumlah_positif'].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xFF6045E2),
                                  ),
                                ),
                                Text(
                                  "Positif",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 110,
                            width: size.width * 0.29,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.blue.withOpacity(0.5)),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  offset: Offset(1, 5),
                                  spreadRadius: -8,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image(
                                  image: AssetImage("assets/images/sembuh.png"),
                                  height: 25,
                                  width: 25,
                                ),
                                Text(
                                  snapshot.data['jumlah_sembuh'].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xFF2ECC71),
                                  ),
                                ),
                                Text(
                                  "Sembuh",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 110,
                            width: size.width * 0.29,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.blue.withOpacity(0.5)),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  offset: Offset(1, 5),
                                  spreadRadius: -8,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image(
                                  image:
                                      AssetImage("assets/images/meninggal.png"),
                                  height: 25,
                                  width: 25,
                                ),
                                Text(
                                  snapshot.data['jumlah_meninggal'].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                  "Meninggal",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Chart
                      Container(
                        height: 190,
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Color(0xFF278BD8).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(2, 4),
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 10,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.blue.withOpacity(0.5),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 20),
                                Image(
                                  image:
                                      AssetImage("assets/images/statistik.png"),
                                  height: 25,
                                  width: 25,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Grafik Data Covid",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 120,
                                  width: 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 100,
                                            width: 10,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF6045E2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          Container(
                                            height: positifData,
                                            width: 10,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Positif",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 120,
                                  width: 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 100,
                                            width: 10,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          Container(
                                            height: sembuhData,
                                            width: 10,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Sembuh",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 120,
                                  width: 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 100,
                                            width: 10,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          Container(
                                            height: meninggalData,
                                            width: 10,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Meninggal",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: 200)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 135,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardLoading(
                      height: 15,
                      width: 130,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CardLoading(
                          height: 100,
                          width: MediaQuery.of(context).size.width * 0.29,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        CardLoading(
                          height: 100,
                          width: MediaQuery.of(context).size.width * 0.29,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        CardLoading(
                          height: 100,
                          width: MediaQuery.of(context).size.width * 0.29,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 135,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Layanan Covid Analys",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.RUJUKAN);
                          },
                          child: Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.29,
                            decoration: BoxDecoration(
                              color: Colors.blue[300],
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(1, 5),
                                  color: Colors.grey,
                                  blurRadius: 10,
                                  spreadRadius: -5,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image(
                                  image: AssetImage(
                                    "assets/images/LayananCovid/rumah-sakit.png",
                                  ),
                                  height: 45,
                                  width: 45,
                                ),
                                Text(
                                  "RS Rujukan",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.HOTLINE);
                          },
                          child: Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.29,
                            decoration: BoxDecoration(
                              color: Colors.blue[300],
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(1, 5),
                                  color: Colors.grey,
                                  blurRadius: 10,
                                  spreadRadius: -5,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image(
                                  image: AssetImage(
                                    "assets/images/LayananCovid/hotline.png",
                                  ),
                                  height: 45,
                                  width: 45,
                                ),
                                Text(
                                  "Hotline",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.INTERNASIONAL);
                          },
                          child: Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.29,
                            decoration: BoxDecoration(
                              color: Colors.blue[300],
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(1, 5),
                                  color: Colors.grey,
                                  blurRadius: 10,
                                  spreadRadius: -5,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image(
                                  image: AssetImage(
                                    "assets/images/LayananCovid/data-internasional.png",
                                  ),
                                  height: 45,
                                  width: 45,
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  "Data\nInternasional",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class HeaderAppBar extends StatelessWidget {
  const HeaderAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: 200)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Stack(
            children: [
              CardLoading(
                height: 150,
                width: MediaQuery.of(context).size.width,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              Positioned(
                top: 20,
                left: 20,
                child: CardLoading(
                  height: 25,
                  width: 290,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Positioned(
                top: 50,
                left: 20,
                child: CardLoading(
                  height: 25,
                  width: 190,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Positioned(
                top: 80,
                width: MediaQuery.of(context).size.width,
                child: CardLoading(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          );
        } else {
          return Stack(
            children: [
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xFF278BD8),
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(20),
                    bottomEnd: Radius.circular(20),
                  ),
                ),
              ),
              const Positioned(
                left: 250,
                bottom: 10,
                child: Image(
                  image: AssetImage("assets/images/header-covid.png"),
                  height: 200,
                  width: 200,
                ),
              ),
              const Positioned(
                top: 20,
                left: 20,
                child: Text(
                  "Analisis Covid 19 Indonesia",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              const Positioned(
                top: 50,
                left: 20,
                child: Text(
                  "Lawan Covid 19 dengan kekuatan bersama!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 80,
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: EdgeInsets.only(left: 20),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Indonesia",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
