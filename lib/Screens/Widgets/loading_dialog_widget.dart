import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

void showLoadingDialog(BuildContext context,
    {Color? colorSpin, String? message}) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  showDialog(
    context: context,
    // barrierDismissible: false,
    builder: (context) => AlertDialog(
      content: Container(
        height: height / 5,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SpinKitDoubleBounce(
                color: colorSpin ?? Colors.blue,
                size: 50,
                duration: const Duration(seconds: 1),
              ),
            ),
            Text(
              '$message',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: GoogleFonts.nunito().fontFamily,
                  fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
