import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/internasional_controller.dart';

class InternasionalView extends GetView<InternasionalController> {
  const InternasionalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InternasionalView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'InternasionalView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
