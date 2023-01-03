import 'package:flutter/material.dart';
import 'package:mon_plateau/app/widgets/text_widget.dart';


class NoDataWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(text: "Aucune donnee trouvée", fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.bold,)
          ],
      ),
    );
  }
}