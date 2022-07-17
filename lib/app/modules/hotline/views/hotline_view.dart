import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/hotline_controller.dart';

class HotlineView extends GetView<HotlineController> {
  const HotlineView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HotlineView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'HotlineView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
