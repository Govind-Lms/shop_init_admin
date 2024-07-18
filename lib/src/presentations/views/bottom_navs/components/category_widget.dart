import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryWidget extends StatelessWidget {
  final String name;
  final String image;
  final Color color;
  final double angle;
  const CategoryWidget(
      {super.key,
      required this.name,
      required this.image,
      required this.color, required this.angle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const[
          BoxShadow(
            blurRadius: 5.0,
            offset: Offset( 6, 6),
            color: Colors.black12,
          )
        ]
      ),
      margin: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Positioned(
            top: 10.0,
            left: 10.0,
            child: Text(
              name,
              style: GoogleFonts.bebasNeue().copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const Positioned(
            bottom: -70,
            right: -70.0,
            child: CircleAvatar(
              radius: 100.0,
              backgroundColor: Colors.white,
            )
          ),
          Positioned(
            bottom: -90,
            right: -90.0,
            child: CircleAvatar(
              radius: 120.0,
              backgroundColor: Colors.white.withOpacity(.5),
            )
          ),
          Positioned(
            bottom: -80,
            right: -80.0,
            child: CircleAvatar(
              radius: 110.0,
              backgroundColor: Colors.white.withOpacity(.5),
            )
          ),
          Positioned(
            bottom: -40,
            right: -40.0,
            child: Transform.rotate(
              angle: angle,
              child: Image.asset(
                image,
                width: 150.0,
                height: 150.0,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}







