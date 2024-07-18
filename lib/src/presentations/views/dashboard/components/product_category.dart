import 'package:flutter/material.dart';
import 'package:shop_init_admin/src/consts/uiconst.dart';

class ProductCategoryWidget extends StatelessWidget {
  final String name;
  final String image;
  const ProductCategoryWidget({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1)
      ),
      child: Center(child: Text(name.toUpperCase(), style: ViceStyle.normalStyle.copyWith(fontWeight: FontWeight.bold),)),
    );
  }
}