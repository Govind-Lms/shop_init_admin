import 'package:flutter/material.dart';
import 'package:shop_init_admin/src/core/models/item_model.dart';
import 'package:shop_init_admin/src/core/notifier/selected_notifier.dart';
import 'package:shop_init_admin/src/presentations/widgets/choice_chip.dart';

class SizePart extends StatelessWidget {
  final List<dynamic>? attributes;
  const SizePart({super.key, required this.attributes});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedSize,
      builder: (context, size, child) {
        final sizesData = attributes![1];
        final sizes = AttributeModel.fromJson(sizesData);
        return Wrap(
          spacing: 10,
          children: List.generate(sizes.values!.length, (index) {
            return ChoiceChipWidget(
              name: sizes.values![index],
              isSelected: size == sizes.values![index],
              isColor: false,
              color: getColor(sizes.values![index].toLowerCase()),
              onSelected: (value) {
                print("selectedColor $size");
                print("Selected ${sizes.values![index]}");
                print("Selected $value");
                if (value) {
                  size = sizes.values![index];
                  selectedSize.value = size;
                } else {
                  size = "";
                  selectedSize.value = '';
                }
              },
            );
          }),
        );
      },
    );
  }
}
