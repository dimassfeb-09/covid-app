import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';

import '../controllers/internasional_controller.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class InternasionalView extends GetView<InternasionalController> {
  const InternasionalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF278BD8),
        elevation: 0,
        title: const Text('Data Internasional'),
        centerTitle: true,
      ),
      body: UpdateTerkini(),
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
    Uri url = Uri.parse("https://api.covid19api.com/summary");
    var response = await http.get(url);

    var decode = jsonDecode(response.body)['Global'];

    return decode;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        SizedBox(
          height: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Update Hari Ini",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(DateFormat.yMMMMd().format(DateTime.now()).toString()),
                ],
              ),
              SizedBox(height: 12),
              FutureBuilder(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        children: const [
                          SizedBox(height: 30),
                          CircularProgressIndicator(
                            color: Color(0xFF5C42DC),
                            backgroundColor: Color(0xAA5C42DC),
                          ),
                        ],
                      ),
                    );
                  } else {
                    int positif = snapshot.data['NewConfirmed'];
                    int sembuh = snapshot.data['NewRecovered'];
                    int meninggal = snapshot.data['NewDeaths'];
                    // int sembuh = 10000000;
                    // int meninggal = 10000000;
                    // int positif = 10000000;

                    late double positifData;
                    late double sembuhData;
                    late double meninggalData;

                    positifData = 100 -
                        positif / (positif + sembuh + meninggal) * 1 * 100;
                    sembuhData =
                        100 - sembuh / (positif + sembuh + meninggal) * 1 * 100;
                    meninggalData = 100 -
                        meninggal / (positif + sembuh + meninggal) * 1 * 100;

                    print(positifData);
                    print(sembuhData);
                    print(meninggalData);

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.29,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.blue.withOpacity(0.5)),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 10,
                                    offset: Offset(1, 5),
                                    spreadRadius: -8,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Image(
                                    image:
                                        AssetImage("assets/images/positif.png"),
                                    height: 25,
                                    width: 25,
                                  ),
                                  Text(
                                    snapshot.data['NewConfirmed'].toString(),
                                    style: const TextStyle(
                                      color: Color(0xFF6045E2),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Text(
                                    "Positif",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.29,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.blue.withOpacity(0.5)),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 10,
                                    offset: Offset(1, 5),
                                    spreadRadius: -8,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Image(
                                    image:
                                        AssetImage("assets/images/sembuh.png"),
                                    height: 25,
                                    width: 25,
                                  ),
                                  Text(
                                    snapshot.data['NewRecovered'].toString(),
                                    style: const TextStyle(
                                      color: Color(0xFF2ECC71),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Text(
                                    "Sembuh",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.29,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.blue.withOpacity(0.5)),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 10,
                                    offset: Offset(1, 5),
                                    spreadRadius: -8,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Image(
                                    image: AssetImage(
                                        "assets/images/meninggal.png"),
                                    height: 25,
                                    width: 25,
                                  ),
                                  Text(
                                    snapshot.data['NewDeaths'].toString(),
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Text(
                                    "Meninggal",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 190,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 15,
                                color: Colors.blue,
                                spreadRadius: -10,
                                offset: Offset(1, 5),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.blue.withOpacity(0.5),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Image(
                                image:
                                    AssetImage("assets/images/statistik.png"),
                                height: 25,
                                width: 25,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                        Text("Positif"),
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
                                                color: Color(0xFF2ECC71),
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
                                        Text("Sembuh"),
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
                                        Text("Meninggal"),
                                      ],
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
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Internasional",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(DateFormat.yMMMMd().format(DateTime.now()).toString()),
                ],
              ),
              SizedBox(height: 12),
              FutureBuilder(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        children: const [
                          SizedBox(height: 30),
                          CircularProgressIndicator(
                            color: Color(0xFF5C42DC),
                            backgroundColor: Color(0xAA5C42DC),
                          ),
                        ],
                      ),
                    );
                  } else {
                    int positif = snapshot.data['TotalConfirmed'];
                    int sembuh = snapshot.data['TotalRecovered'];
                    int meninggal = snapshot.data['TotalDeaths'];

                    late double positifData;
                    late double sembuhData;
                    late double meninggalData;

                    positifData = 100 -
                        positif / (positif + sembuh + meninggal) * 1 * 100;
                    sembuhData =
                        100 - sembuh / (positif + sembuh + meninggal) * 1 * 100;
                    meninggalData = 100 -
                        meninggal / (positif + sembuh + meninggal) * 1 * 100;

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.29,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.blue.withOpacity(0.5)),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 10,
                                    offset: Offset(1, 5),
                                    spreadRadius: -8,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Image(
                                    image:
                                        AssetImage("assets/images/positif.png"),
                                    height: 25,
                                    width: 25,
                                  ),
                                  Text(
                                    snapshot.data['TotalConfirmed'].toString(),
                                    style: const TextStyle(
                                      color: Color(0xFF6045E2),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Text(
                                    "Positif",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.29,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.blue.withOpacity(0.5)),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 10,
                                    offset: Offset(1, 5),
                                    spreadRadius: -8,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Image(
                                    image:
                                        AssetImage("assets/images/sembuh.png"),
                                    height: 25,
                                    width: 25,
                                  ),
                                  Text(
                                    snapshot.data['TotalRecovered'].toString(),
                                    style: const TextStyle(
                                      color: Color(0xFF2ECC71),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Text(
                                    "Sembuh",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.29,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.blue.withOpacity(0.5)),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 10,
                                    offset: Offset(1, 5),
                                    spreadRadius: -8,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Image(
                                    image: AssetImage(
                                        "assets/images/meninggal.png"),
                                    height: 25,
                                    width: 25,
                                  ),
                                  Text(
                                    snapshot.data['TotalDeaths'].toString(),
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Text(
                                    "Meninggal",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 190,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 15,
                                color: Colors.blue,
                                spreadRadius: -10,
                                offset: Offset(1, 5),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.blue.withOpacity(0.5),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Image(
                                image:
                                    AssetImage("assets/images/statistik.png"),
                                height: 25,
                                width: 25,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                        Text("Positif"),
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
                                                color: Color(0xFF2ECC71),
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
                                        Text("Sembuh"),
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
                                        Text("Meninggal"),
                                      ],
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
