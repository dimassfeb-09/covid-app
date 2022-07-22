import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/detail_r_s.controller.dart';

class DetailRSScreen extends GetView<DetailRSController> {
  const DetailRSScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailRSScreen'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DetailRSScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
