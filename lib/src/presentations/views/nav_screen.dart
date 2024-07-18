import 'package:flutter/material.dart';
import 'package:shop_init_admin/src/consts/uiconst.dart';
import 'package:shop_init_admin/src/presentations/views/bottom_navs/account_screen.dart';
import 'package:shop_init_admin/src/presentations/views/bottom_navs/dashboard_screen.dart';
import 'package:shop_init_admin/src/presentations/views/bottom_navs/management_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen>
    with TickerProviderStateMixin {
  var _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: [
        const AccountScreen(),
        const ManagementScreen(),
        DashboardScreen(),
      ][_bottomNavIndex],
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(

          currentIndex: _bottomNavIndex,
          fixedColor: theme.primaryColorDark,
          elevation: 0,
          items:  [
            BottomNavigationBarItem(
              backgroundColor: theme.primaryColor,
                activeIcon: const Icon(NavIcons.dashboard_fill),
                icon: Icon(NavIcons.dashboard, color: theme.primaryColorDark),
                label: "Dashboard"),
            BottomNavigationBarItem(
              backgroundColor: theme.primaryColor,
              activeIcon: const Icon(NavIcons.orders_fill),
                icon: Icon(NavIcons.orders, color: theme.primaryColorDark),
                label: "Users"),
            BottomNavigationBarItem(
              backgroundColor: theme.primaryColor,
              activeIcon: const Icon(NavIcons.orderLists_fill),
                icon: Icon(NavIcons.orderLists, color: theme.primaryColorDark),
                label: "Order Lists"),
            // BottomNavigationBarItem(
            //   backgroundColor: theme.primaryColor,
            //   activeIcon: const Icon(NavIcons.settings_fill),
            //     icon: Icon(NavIcons.settings, color: theme.primaryColorDark),
            //     label: "Account"),
          ],
          onTap: (index) => setState(() => _bottomNavIndex = index),
        ),
      ),
    );
  }
}
