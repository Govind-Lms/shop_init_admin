import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/consts/style.dart';
import 'package:shop_init_admin/src/core/models/item_model.dart';

class DeleteBannerDialog extends StatelessWidget {
  final ItemModel itemModel;
  const DeleteBannerDialog({super.key,required this.itemModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      backgroundColor: theme.primaryColor,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3,
        child: Column(
          children: [
            const Gap(20.0),
            Text(
              'Remove'.toUpperCase(),
              style: AccountStyle.nameStyle,
            ),
            const Gap(20.0),
            Text(
              'Remove this product from the featured section...',
              style: AccountStyle.emailStyle,
            ),
            const Gap(20.0),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    navPop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(10.0),
                    height: kToolbarHeight,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 1),
                        color: Colors.white),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: AccountStyle.logoutStyle
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async{
                    await bannerRef
                        .doc(itemModel.id)
                        .delete();
                    await itemRef.doc("products").collection(itemModel.category.toString()).doc(itemModel.id).update({
                      'isFeatured' : false,
                    });
                    navPop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(10.0),
                    height: kToolbarHeight,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Theme.of(context).primaryColorDark,
                    ),
                    child: Center(
                      child: Text(
                        'Confirm',
                        style: AccountStyle.logoutStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
