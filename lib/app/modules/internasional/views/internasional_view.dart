import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/internasional_controller.dart';
import 'package:http/http.dart' as http;

class InternasionalView extends GetView<InternasionalController> {
  const InternasionalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6045E2),
        title: const Text('Data Internasional'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            UpdateTerkini(),
          ],
        ),
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
    Uri url = Uri.parse("https://api.covid19api.com/summary");
    var response = await http.get(url);

    var decode = jsonDecode(response.body)['Global'];

    return decode;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1),
      child: Column(
        children: [
          Container(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Update Hari Ini",
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
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            CircularProgressIndicator(
                              color: Color(0xFF5C42DC),
                              backgroundColor: Color(0xAA5C42DC),
                            ),
                          ],
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
                                  image:
                                      AssetImage("assets/images/positif.png"),
                                  height: 26,
                                  width: 26,
                                ),
                                Text(
                                  snapshot.data['NewConfirmed'].toString(),
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
                                  snapshot.data['NewRecovered'].toString(),
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
                                  image:
                                      AssetImage("assets/images/meninggal.png"),
                                  height: 26,
                                  width: 26,
                                ),
                                Text(
                                  snapshot.data['NewDeaths'].toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFF1800),
                                  ),
                                ),
                                Text("Meninggal",
                                    style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
          Container(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Data Dunia",
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
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            CircularProgressIndicator(
                              color: Color(0xFF5C42DC),
                              backgroundColor: Color(0xAA5C42DC),
                            ),
                          ],
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
                                  image:
                                      AssetImage("assets/images/positif.png"),
                                  height: 26,
                                  width: 26,
                                ),
                                Text(
                                  snapshot.data['TotalConfirmed'].toString(),
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
                                  snapshot.data['TotalRecovered'].toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2ECC71),
                                  ),
                                  textAlign: TextAlign.center,
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
                                  image:
                                      AssetImage("assets/images/meninggal.png"),
                                  height: 26,
                                  width: 26,
                                ),
                                Text(
                                  snapshot.data['TotalDeaths'].toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFF1800),
                                  ),
                                ),
                                Text("Meninggal",
                                    style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
