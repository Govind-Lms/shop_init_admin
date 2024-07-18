import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/consts/uiconst.dart';
import 'package:shop_init_admin/src/presentations/views/dashboard/account_details.dart';
import 'package:shop_init_admin/src/presentations/views/dashboard/report_analysis.dart';
import 'package:shop_init_admin/src/presentations/views/bottom_navs/components/setting_widget.dart';
import 'package:shop_init_admin/src/presentations/widgets/custom_app_bar.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              isAnimated: false,
              showSearchBar: false,
              showDefinedName: true,
              name: 'Account',
              showBack: false,
              showColor: false,
              isfilterOn: false,
            ),
            
            const AccountDetailsPart(),
            
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Report Analysis",
                style: ViceStyle.titleStyle.copyWith(fontSize: 16,color: theme.primaryColorDark),
              ),
            ),
            const ReportAnalysisPart(),
            
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Upload Settings",
                style: ViceStyle.titleStyle.copyWith(fontSize: 16,color: theme.primaryColorDark),
              ),
            ),
            
            SettingTileWidget(
              name: 'Upload Products',
              iconData1: Iconsax.document_upload5,
              iconData2: Icons.arrow_circle_up_outlined,
              onTap: () {
                navName(context, '/topSelling');
              },
            ),
            SettingTileWidget(
              name: 'View Banners',
              iconData1: FontAwesomeIcons.windowMaximize,
              iconData2: Icons.arrow_circle_up_outlined,
              onTap: () {
                navName(context, '/viewBanners');
              },
            ),
            SettingTileWidget(
              name: 'View Featured Products',
              iconData1: Iconsax.gallery5,
              iconData2: Icons.arrow_circle_up_outlined,
              onTap: () {
                navName(context, '/dashboard');
              },
            ),
          ],
        ),
      ),
    );
  }
}
