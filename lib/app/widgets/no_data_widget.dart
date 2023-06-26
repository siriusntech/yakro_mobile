import 'package:flutter/material.dart';
import 'package:jaime_cocody/app/widgets/text_widget.dart';


class NoDataWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(text: "Aucune donnée trouvée", fontSize: 20.0, color: Colors.red, fontWeight: FontWeight.bold,)
          ],
      ),
    );
  }
}