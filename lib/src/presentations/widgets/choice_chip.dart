import 'package:flutter/material.dart';

class ChoiceChipWidget extends StatelessWidget {
  const ChoiceChipWidget({super.key, required this.name, required this.isSelected, this.onSelected, this.isColor, this.color});
  final String name;
  final bool isSelected;
  final Color? color;
  final bool? isColor;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: isColor! ? const SizedBox()  : Text(name),
      selected: isSelected,
      onSelected: onSelected,
      labelStyle:TextStyle(
        color: isSelected ? Colors.white : null,
      ),
      avatar: isColor! ? const SizedBox(width: 50,height: 50,) : const SizedBox(width: 150,height: 50,),
      shape:  isColor! ? const CircleBorder() : RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      selectedColor: isColor! ?color : Colors.blue,
      
      showCheckmark: isColor! ? true : false,
      backgroundColor: isColor! ? color : null,
      checkmarkColor:  Colors.white,
      disabledColor:  color,
      labelPadding: isColor! ?  EdgeInsets.zero : const EdgeInsets.all(4),
      padding: isColor! ? EdgeInsets.zero : const EdgeInsets.all(4),
    );
  }
}


Color? getColor(String color){
  switch (color) {
    case 'white' : return Colors.white;
    case 'black' : return Colors.black;
    case 'red' : return  Colors.red;
    case 'pink' : return Colors.pink;
    case 'purple' : return Colors.purple;
    case 'deepPurple' : return Colors.deepPurple;
    case 'indigo' : return Colors.indigo;
    case 'blue' : return Colors.blue;
    case 'lightBlue' : return Colors.lightBlue;
    case 'cyan' : return Colors.cyan;
    case 'teal' : return Colors.teal;
    case 'green' : return Colors.green;
    case 'lightGreen' : return Colors.lightGreen;
    case 'lime' : return Colors.lime;
    case 'yellow' : return Colors.yellow;
    case 'amber' : return Colors.amber;
    case 'orange' : return Colors.orange;
    case 'deepOrange' : return Colors.deepOrange;
    case 'brown' : return Colors.brown;
  }
  return Colors.green;
}
