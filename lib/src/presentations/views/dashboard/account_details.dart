import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_init_admin/src/consts/style.dart';
import 'package:shop_init_admin/src/consts/uiconst.dart';

class AccountDetailsPart extends StatelessWidget {
  const AccountDetailsPart({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: theme.primaryColorLight,
        boxShadow: [
          BoxShadow(
            offset: const Offset(3, 3),
            color: theme.primaryColorDark.withOpacity(.3),
            blurRadius:6,
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
       margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Center(
              child: ClipOval(
                child: CachedNetworkImage(
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.cover,
                  imageUrl: 'https://images.unsplash.com/photo-1718931216622-c25c7ae7526f?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHw4fHx8ZW58MHx8fHx8',
                ),
              ),
            ),
            const Gap(10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ShopInit",
                  style: AccountStyle.nameStyle.copyWith(fontSize: 14,color: theme.primaryColorDark),
                ),
                Text(
                  "ordernow.si@gmail.com",
                  style: AccountStyle.emailStyle.copyWith(fontSize: 12,color: theme.primaryColorDark),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  // navName(context, '/account_details');
                },
                icon:  Icon(
                  ViceIcons.edit,
                  color: theme.primaryColorDark,
                )),
          ],
        ),
      ),
    );
  }
}
