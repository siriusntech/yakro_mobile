import 'package:flutter/material.dart';

import '../../../Utils/app_constantes.dart';
import '../../../controllers/main_controller.dart';
import '../controllers/splash_controller.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  final ctrl = SplashController();
  // final main_ctrl = MainController();

  @override
  void initState() {
    super.initState();
    // main_ctrl.checkAppName();
    ctrl.navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: mainColorYakro,
          child: Center(
            child: CircleAvatar(
              backgroundColor: mainColorYakro,
              radius: 135,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 230,
                    child: Image.asset(LOGO_BLANC, fit: BoxFit.contain),
                  ),
                  Text("je teste"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

