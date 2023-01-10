import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


import '../../../Utils/app_constantes.dart';
import '../controllers/splash_controller.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  final ctrl = SplashController();

  @override
  void initState() {
    super.initState();
    ctrl.navigateToHome();
  }

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
              backgroundColor: mainColor,
              radius: 135,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 230,
                    child: Image.asset(LOGO_BLANC, fit: BoxFit.contain,),
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

