import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';

class CardElement extends StatefulWidget {
  final double height;
  final double width;
  final Color color;
  final Color textColor;
  final String title;
  final String imgPath;
  final BoxFit fit;
  final Callback onTap;
  const CardElement(
      {super.key,
      required this.height,
      required this.width,
      required this.color,
      required this.textColor,
      required this.title,
      required this.fit,
      required this.imgPath,
      required this.onTap});

  @override
  State<CardElement> createState() => _CardElementState();
}

class _CardElementState extends State<CardElement> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Expanded(
      child: InkWell(
        onTap: widget.onTap,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConfig.cardRadius)),
          borderOnForeground: true,
          elevation: 10,
          shadowColor: widget.color,
          color: widget.color,
          child: Stack(
            children: [
              Container(
                height: height / 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConfig.cardRadius),
                    image: DecorationImage(
                      image: AssetImage(widget.imgPath),
                      fit: widget.fit,
                    )),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 50,
                  width: 198,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(AppConfig.cardRadius),
                          bottomRight: Radius.circular(
                              AppConfig.cardRadius)) // Couleur de fond
                      ),
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: widget.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.nunito().fontFamily),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
