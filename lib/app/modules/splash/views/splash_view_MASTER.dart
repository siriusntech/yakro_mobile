import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../Utils/app_constantes.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: mainColor,
          child: Center(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 110,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    child: Image.asset(LOGO),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
