import 'dart:convert';

import 'package:covid/app/modules/rujukan/controllers/rujukan_controller.dart';
import 'package:covid/app/modules/rujukan/views/rujukan_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controllers/rujukanrs_controller.dart';

class RujukanrsView extends GetView<RujukanrsController> {
  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    RujukanController rujukanController = RujukanController();

    List allData = [];

    print(arguments);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6045E2),
        title: const Text('Detail Rujukan RS'),
        centerTitle: true,
      ),
      body: Text("data"),
    );
  }
}
