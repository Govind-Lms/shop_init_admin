import 'package:flutter/material.dart';
import 'package:shop_init_admin/src/core/models/item_model.dart';
import 'package:shop_init_admin/src/core/notifier/selected_notifier.dart';
import 'package:shop_init_admin/src/presentations/widgets/choice_chip.dart';

class ColorPart extends StatelessWidget {
  final List<dynamic>? attributes;
  const ColorPart({super.key, required this.attributes});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedColor,
      builder: (context, color, child) {
        final colorData = attributes![0];
        final colors = AttributeModel.fromJson(colorData);
        return Wrap(
          spacing: 10,
          children: List.generate(colors.values!.length, (index) {
            return ChoiceChipWidget(
              name: colors.values![index],
              isSelected: color == colors.values![index],
              isColor: true,
              color: getColor(colors.values![index].toLowerCase()),
              onSelected: (value) {
                print("selectedColor $color");
                print("Selected ${colors.values![index]}");
                print("Selected $value");
                if (value) {
                  color = colors.values![index];
                  selectedColor.value = color;
                } else {
                  color = "";
                  selectedColor.value = '';
                }
              },
            );
          }),
        );
      },
    );
  }
}
