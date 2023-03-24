import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cocan_controller.dart';

class CocanView extends GetView<CocanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CocanView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CocanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
