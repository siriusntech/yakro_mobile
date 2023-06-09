import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bars_maquis_controller.dart';

class BarsMaquisView extends GetView<BarsMaquisController> {
  const BarsMaquisView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BarsMaquisView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'BarsMaquisView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
