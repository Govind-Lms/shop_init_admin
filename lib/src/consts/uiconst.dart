


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class UIConsts {
  UIConsts._();
  static const BoxDecoration gradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.3, 1],
      colors: UIColors.scaffoldColors,
    ),
  );

  static double headerHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.65;
  }
}





class UIColors {
  const UIColors._();
  static const purple = Colors.purpleAccent;
  static const lightGreen = Colors.greenAccent;
  static const textColor = Colors.black;
  static const List<Color> scaffoldColors = [
    Color(0xff9876cc),
    Color(0xff80c7a9),
  ];
}


class ViceIcons {
  const ViceIcons._();
  static const IconData search = CupertinoIcons.search;
  static const IconData person = CupertinoIcons.person;
  static const IconData dropdown = Icons.arrow_drop_down;
  static const IconData dropup = Icons.arrow_drop_up;
  static const IconData check = CupertinoIcons.check_mark;
  static const IconData edit = CupertinoIcons.person;
  static const IconData minus = CupertinoIcons.minus;
  static const IconData plus = CupertinoIcons.plus;
  static const IconData menu = CupertinoIcons.line_horizontal_3_decrease;
  static const IconData lock = CupertinoIcons.lock_fill;
  static const IconData home = CupertinoIcons.home;
  static const IconData settings = CupertinoIcons.settings;
  static const IconData share = CupertinoIcons.share;
  static const IconData heart = CupertinoIcons.heart;
  static const IconData close = CupertinoIcons.clear_circled_solid;
  static const IconData save = CupertinoIcons.bookmark;
  static const IconData noti = CupertinoIcons.bell;
  static const IconData category = Icons.dashboard;
  static const IconData cart = CupertinoIcons.shopping_cart;
  static const IconData heartFill = CupertinoIcons.heart_fill;
  static const IconData orders = CupertinoIcons.shopping_cart;
}


class ViceStyle {
  ViceStyle._();
  static  TextStyle titleStyle = GoogleFonts.poppins().copyWith(
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
    color: const Color(0xff1a1a1a),
  );
  static  TextStyle normalStyle = GoogleFonts.poppins().copyWith(
    fontWeight: FontWeight.normal,
    fontSize: 14.0,
    color: const Color(0xff1a1a1a),
  );
  static  TextStyle descStyle = GoogleFonts.poppins().copyWith(
    fontWeight: FontWeight.normal,
    fontSize: 12.0,
    color: const Color(0xff1a1a1a),
  );
  static  TextStyle priceStyle = GoogleFonts.poppins().copyWith(
    fontWeight: FontWeight.normal,
    fontSize: 12.0,
    color: const Color(0xff1a1a1a),
    decoration: TextDecoration.lineThrough,
  );
  static  TextStyle discountedPriceStyle = GoogleFonts.poppins().copyWith(
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
    color: const Color(0xff1a1a1a),
  );
}




class NavIcons {
  const NavIcons._();
  static const IconData dashboard = Iconsax.category;
  static const IconData orders = Iconsax.shopping_cart;
  static const IconData orderLists = Iconsax.shopping_bag;
  static const IconData settings = Iconsax.setting;
  static const IconData cart = Iconsax.presention_chart;


  static const IconData dashboard_fill = Iconsax.category5;
  static const IconData orders_fill = Iconsax.shopping_cart5;
  static const IconData orderLists_fill = Iconsax.shopping_bag5;
  static const IconData settings_fill = Iconsax.setting5;
  static const IconData cart_fill = Iconsax.presention_chart5;
}