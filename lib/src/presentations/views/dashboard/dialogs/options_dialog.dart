import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/consts/style.dart';
import 'package:shop_init_admin/src/core/models/item_model.dart';
import 'package:shop_init_admin/src/presentations/views/dashboard/components/options_widget.dart';
import 'package:shop_init_admin/src/presentations/views/dashboard/dialogs/add_stocks_dialog.dart';
import 'package:shop_init_admin/src/presentations/views/product/add/update_product.dart';
import 'package:shop_init_admin/src/presentations/views/product/view/product_details.dart';
import 'package:shop_init_admin/src/presentations/views/dashboard/dialogs/delete_dialog.dart';

class OptionsDialog extends StatelessWidget {
  final ItemModel productModel;
  const OptionsDialog({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final colorData = productModel.attributes![0];
    final sizeData = productModel.attributes![1];
    final colors = AttributeModel.fromJson(colorData);
    final sizes = AttributeModel.fromJson(sizeData);
    final theme = Theme.of(context);
    return Dialog(
      backgroundColor: theme.primaryColor,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          children: [
            const Gap(10.0),
            Text(
              'OPTIONS',
              style: AccountStyle.nameStyle,
            ),
            const Gap(10.0),
            const Divider(),
            OptionWidget(
              optionName: "View Product Info",
              onTap: () {
                navPop(context);
                nav(context, ProductDetailsScreen(productModel: productModel));
              },
            ),
            OptionWidget(
              optionName: "Add Stocks",
              onTap: () {
                
                nav(context,
                    AddStocksDialog(productId: productModel.id.toString()));
                    
              },
            ),
            OptionWidget(
              optionName: "Edit Details",
              onTap: () {
                navPop(context);
                nav(
                    context,
                    UpdateProductItem(
                      itemModel: productModel,
                      colors: colors,
                      sizes: sizes,
                    ));
              },
            ),
            OptionWidget(
              optionName: "Delete",
              isColor: true,
              onTap: () {
                navPop(context);
                nav(context, DeleteDialog(id: productModel.id.toString()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
