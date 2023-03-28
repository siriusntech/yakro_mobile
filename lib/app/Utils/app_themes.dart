

import 'package:flutter/material.dart';
import 'package:jaime_cocody/app/Utils/app_colors.dart';

class AppThemes {
  static final ThemeData cocodyTheme = ThemeData(
    primarySwatch: AppColors.mainColor,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.grey,
      cursorColor: Colors.deepOrange,
      selectionHandleColor: Colors.deepOrangeAccent,
    ),
    floatingActionButtonTheme:
    FloatingActionButtonThemeData (backgroundColor: Colors.orange,focusColor: Colors.orangeAccent , splashColor: Colors.orange),
  );

  static final ThemeData plateauTheme = ThemeData(
    primarySwatch: Colors.blue,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.grey,
      cursorColor: Colors.blueAccent,
      selectionHandleColor: Colors.lightBlueAccent,
    ),
    floatingActionButtonTheme:
    FloatingActionButtonThemeData (backgroundColor: Colors.blue,focusColor: Colors.blueAccent , splashColor: Colors.blue),
  );

}