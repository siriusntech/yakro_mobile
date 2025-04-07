import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarCustom extends StatelessWidget {
  final String categorie;
  const AppBarCustom({super.key, required this.categorie});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ConstColors.vertColorFonce,
      title: Text('Yakro',
          style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.taprom().fontFamily)),
      centerTitle: true,
      actions: [
        PopupMenuButton<String>(
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(
                value: 'Sondage',
                child: InkWell(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.keyboard_voice),
                    Text('Sondage'),
                  ],
                )),
              ),
              const PopupMenuItem<String>(
                value: 'Contactez Nous',
                child: InkWell(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.phone),
                    Text('Contactez Nous'),
                  ],
                )),
              ),
              const PopupMenuItem<String>(
                value: 'Aide',
                child: InkWell(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.help),
                    Text('Aide'),
                  ],
                )),
              ),
              const PopupMenuItem<String>(
                value: 'Partagez',
                child: InkWell(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.share),
                    Text("Partagez l'appli"),
                  ],
                )),
              ),
            ];
          },
        ),
      ],
    );
  }
}
