import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/consts/style.dart';
import 'package:shop_init_admin/src/consts/uiconst.dart';

class AddStocksDialog extends StatelessWidget {
  final String productId;
  const AddStocksDialog({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    int stocks =0;
    return Dialog(
      backgroundColor: theme.primaryColor,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3,
        child: Column(
          children: [
            const Gap(20.0),
            Text(
              'Add'.toUpperCase(),
              style: AccountStyle.nameStyle,
            ),
            const Gap(20.0),
            Text(
              'Add Some Stocks to the shop...',
              style: AccountStyle.emailStyle,
            ),
            const Gap(20.0),
            Container(
              width: 240,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey.shade100,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(3, 3),
                    blurRadius: 6,
                    color: Colors.black12,
                  )
                ]),
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(ViceIcons.plus),
                    border: InputBorder.none,
                    hintText: 'Add Stocks'),
                    keyboardType: TextInputType.number,
                    onChanged: (value){
                      stocks = int.parse(value);
                    },
              ),
            ),
            const Gap(20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    navPop(context);
                    navPop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(10.0),
                    height: kToolbarHeight,
                    width: MediaQuery.of(context).size.width /3.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 1),
                        color: Colors.white),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: AccountStyle.settingStyle
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async{
                    await itemRef
                        .doc('products')
                        .collection(categoryName)
                        .doc(productId.toString())
                        .update({
                          "stocks" : stocks,
                        });
                    navPop(context);
                    navPop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(10.0),
                    height: kToolbarHeight,
                    width: MediaQuery.of(context).size.width /3.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Theme.of(context).primaryColorDark,
                    ),
                    child: Center(
                      child: Text(
                        'Confirm',
                        style: AccountStyle.settingStyle.copyWith(color: Colors.white),
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
