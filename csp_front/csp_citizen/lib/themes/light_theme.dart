import 'package:flutter/material.dart';

ThemeData lighttheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor:  Color(0xFF698996),
  ),
    buttonTheme: const ButtonThemeData(buttonColor: Color(0xFF698996)),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Color(0xFF698996)),
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
          backgroundColor: Color.fromARGB(255, 211, 211, 211)
          
          
          ),
    
  colorScheme: const ColorScheme.light(
    background: Color.fromARGB(255, 202, 202, 202),
    primary:Color(0xFF698996),
    secondary: Color(0xFFC9C5BA),
    tertiary: Color(0xFF97B1A6),
    onSecondary: Colors.white
  

  
    
  )
);