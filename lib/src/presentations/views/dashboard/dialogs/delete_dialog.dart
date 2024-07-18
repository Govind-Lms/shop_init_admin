import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/consts/style.dart';

class DeleteDialog extends StatelessWidget {
  final String id;
  const DeleteDialog({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      backgroundColor:  theme.primaryColor,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3,
        child: Column(
          children: [
            const Gap(20.0),
            Text(
              'Delete'.toUpperCase(),
              style: AccountStyle.nameStyle,
            ),
            const Gap(20.0),
            Text(
              'Are you sure you want to delete?',
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
                    await itemRef
                        .doc('products')
                        .collection(categoryName)
                        .doc(id.toString())
                        .delete();
                    navPop(context);
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
