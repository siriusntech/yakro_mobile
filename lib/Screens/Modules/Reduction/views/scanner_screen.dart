import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Screens/Modules/Reduction/reduction_path.dart';

class ScannerScreen extends GetView<ScannerScreenController> {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: controller.colorPrimary.value,
          // centerTitle: true,
          title: Center(child: Text('Scanner', style: TextStyle(
              fontSize: 23,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts
                  .taprom()
                  .fontFamily)),),
        ),
      body: const ScannerComponent(),
    );
  }
}