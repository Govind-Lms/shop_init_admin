


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AccountStyle {
  AccountStyle._();
  static TextStyle nameStyle = GoogleFonts.poppins().copyWith(
    color: const Color(0xff1a1a1a),
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
  );
  static TextStyle logoutStyle = GoogleFonts.poppins().copyWith(
    color: const Color(0xfffff7f1),
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
  );

  static TextStyle emailStyle = GoogleFonts.poppins().copyWith(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: const Color(0xff1a1a1a),
  );
  static TextStyle settingStyle = GoogleFonts.poppins().copyWith(
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    color: const Color(0xff1a1a1a),
  );
   static TextStyle settingDescStyle = GoogleFonts.poppins().copyWith(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: const Color(0xff1a1a1a),
  );
}


class ProductStyle {
  ProductStyle._();
  static TextStyle discountStyle = GoogleFonts.poppins().copyWith(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 12.0,
  );


  static TextStyle productNameStyle = GoogleFonts.poppins().copyWith(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: const Color(0xff1a1a1a),
  );


  static TextStyle categoryStyle = GoogleFonts.poppins().copyWith(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: const Color(0xff1a1a1a),
    wordSpacing: 10
  );

  static TextStyle priceStyle = GoogleFonts.poppins().copyWith(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: const Color(0xff1a1a1a),
    wordSpacing: 10,
  );
}
