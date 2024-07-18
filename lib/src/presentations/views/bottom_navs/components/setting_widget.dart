import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_init_admin/src/consts/uiconst.dart';

class SettingTileWidget extends StatelessWidget {
  final String name;
  final IconData iconData1;
  final IconData iconData2;
  final VoidCallback onTap;
  const SettingTileWidget({super.key, required this.name, required this.iconData1, required this.iconData2, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              // IconsaxBold.document_upload,
              iconData1,
              color: theme.primaryColorDark,
            ),
            const Gap(10),
            Text(
              name,
              style: ViceStyle.descStyle.copyWith(color: theme.primaryColorDark),
            ),
            const Spacer(),
            Icon(
              iconData2,
              color: theme.primaryColorDark,
            ),
            const Gap(10.0)
          ],
        ),
      ),
    );
  }
}
