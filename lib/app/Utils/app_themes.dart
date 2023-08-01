import 'package:flutter/material.dart';
import 'package:jaime_yakro/app/Utils/app_colors.dart';

class AppThemes {
  static final ThemeData cocodyTheme = ThemeData(
    primarySwatch: AppColors.mainColor,
    textSelectionTheme: TextSelectionThemeData(
        selectionColor: Colors.grey,
        cursorColor: AppColors.vert_color,
        selectionHandleColor: AppColors.vert_color),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.vert_color_fonce,
      focusColor: AppColors.vert_color,
      splashColor: AppColors.vert_color_fonce,
    ),
  );

  static final ThemeData plateauTheme = ThemeData(
    primarySwatch: Colors.blue,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.grey,
      cursorColor: Colors.blueAccent,
      selectionHandleColor: Colors.lightBlueAccent,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.blue,
        focusColor: Colors.blueAccent,
        splashColor: Colors.blue),
  );

//Yakro
  static final ThemeData yakroTheme = ThemeData(
    primarySwatch: AppColors.mainColor,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.blueGrey,
      cursorColor: Colors.blueAccent,
      selectionHandleColor: Colors.lightBlueAccent,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.blue,
        focusColor: Colors.blueAccent,
        splashColor: Colors.blue),
  );
}
