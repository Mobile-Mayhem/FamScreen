import 'package:flutter/material.dart';
import 'Colors.dart';

final ThemeData customTheme = ThemeData(
  primaryColor: CustomColor.primary,
  brightness: Brightness.light,
  scaffoldBackgroundColor: CustomColor.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: CustomColor.primary,
    elevation: 1,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        color: CustomColor.black, fontSize: 24, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(color: CustomColor.black, fontSize: 16),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: CustomColor.primary,
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: CustomColor.white,
      backgroundColor: CustomColor.primary,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: CustomColor.primary,
    ),
  ),
);
