import 'package:flutter/material.dart';
import 'package:jaime_cocody/app/Utils/app_constantes.dart';


class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: CircularProgressIndicator(color: mainColor),
      ),
    );
  }
}