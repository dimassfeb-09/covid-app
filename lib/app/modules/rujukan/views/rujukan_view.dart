import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rujukan_controller.dart';

class RujukanView extends GetView<RujukanController> {
  const RujukanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RujukanView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RujukanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
