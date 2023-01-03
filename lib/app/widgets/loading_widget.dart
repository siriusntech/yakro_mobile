import 'package:flutter/material.dart';
import 'package:mon_plateau/app/Utils/app_constantes.dart';


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