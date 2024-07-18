import 'package:flutter/material.dart';
import 'package:shop_init_admin/src/consts/style.dart';

class OptionWidget extends StatelessWidget {
  final String optionName;
  final VoidCallback onTap;
  final bool? isColor;
  const OptionWidget(
      {super.key,this.isColor, required this.optionName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10.0),
        height: kToolbarHeight,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: isColor == true ? null : Border.all(width: 1),
          color: isColor == true ? Theme.of(context).primaryColorDark : Colors.white,
        ),
        child: Center(
          child: Text(
            optionName,
            style: AccountStyle.settingStyle.copyWith(
              color: isColor == true ?  Theme.of(context).primaryColorLight : Colors.black),
          ),
        ),
      ),
    );
  }
}
