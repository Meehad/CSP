import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 31, 31, 31)
  ),
  buttonTheme: const ButtonThemeData(buttonColor: Color.fromARGB(255, 35, 35, 35)),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 67, 67, 67)),
            foregroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 213, 213, 213)),
          ),
        ),
    cardTheme: CardTheme(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ), 
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color.fromARGB(255, 46, 46, 46)
          
        ) ,
  colorScheme: const ColorScheme.dark(
    background: Color.fromARGB(255, 29, 29, 29),
    primary:Color.fromARGB(255, 35, 35, 35),
    secondary: Color.fromARGB(255, 35, 35, 35),
    tertiary: Color.fromARGB(255, 35, 35, 35)

  )
  );