import 'package:flutter/material.dart';

class MyTheme {
  static final light = ThemeData(

    primaryColorDark: const Color(0xff6f4f37),
    primaryColorLight: const Color(0xfffff7f1),
    primaryColor: const Color(0xfffff7f1),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xfffff7f1),
      elevation: 0,
      // selectedIconTheme: IconThemeData(color: Colors.black)
    ),
  );

  static final dark = ThemeData(
    primaryColorLight: const Color(0xff6f4f37),
    primaryColorDark: const Color(0xfffff7f1),
    primaryColor: const Color(0xff6f4f37),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xff1a1a1a),
      elevation: 0,
      // unselectedIconTheme: IconThemeData(color: Colors.white),
      // unselectedLabelStyle: TextStyle(color: Colors.white),
      // unselectedItemColor: Colors.white,
      // selectedIconTheme: IconThemeData(color: Colors.white)
    ),
  );
}
