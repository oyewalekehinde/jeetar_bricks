/*
* This is a generated Code, to use below code
* You have to uncomment and edit to suite your need.
*/

import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../generated/l10n.dart';
// import '../../shared/utils/asset_images.dart';
// import '../../shared/utils/colors.dart';
// import '../../shared/utils/font_family.dart';

enum Tabs { home, orders, inventory, more }

// extension TabExt on Tabs {
//   String get name {
//     switch (this) {
//       case Tabs.home:
//         return S.current.home;
//       case Tabs.orders:
//         return S.current.orders;
//       case Tabs.inventory:
//         return S.current.inventory;
//       case Tabs.more:
//         return S.current.more;

//       default:
//         return "";
//     }
//   }

//   String get selectedIcon {
//     switch (this) {
//       case Tabs.home:
//         return AssetResources.ACTIVE_HOME_ICON;
//       case Tabs.orders:
//         return AssetResources.ACTIVE_ORDER_ICON;
//       case Tabs.inventory:
//         return AssetResources.ACTIVE_INVENTORY_ICON;
//       case Tabs.more:
//         return AssetResources.ACTIVE_MORE_ICON;

//       default:
//         return "";
//     }
//   }

//   String get unSelectedIcon {
//     switch (this) {
//       case Tabs.home:
//         return AssetResources.INACTIVE_HOME_ICON;
//       case Tabs.orders:
//         return AssetResources.INACTIVE_ORDER_ICON;
//       case Tabs.inventory:
//         return AssetResources.INACTIVE_INVENTORY_ICON;
//       case Tabs.more:
//         return AssetResources.INACTIVE_MORE_ICON;

//       default:
//         return "";
//     }
//   }
// }

class BottomNav extends StatelessWidget {
  final Tabs currentTab;
  final ValueChanged<Tabs> didSelectTab;

  const BottomNav(
      {Key? key, required this.currentTab, required this.didSelectTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // height: Platform.isIOS ? 87.h : 65.h,
        // child: BottomNavigationBar(
        //     currentIndex: Tabs.values.indexOf(currentTab),
        //     unselectedLabelStyle: inActiveTextStyle(),
        //     selectedLabelStyle: activeTextStyle(),
        //     backgroundColor: AppColors.zeptaWhite,
        //     showSelectedLabels: true,
        //     showUnselectedLabels: true,
        //     selectedItemColor: AppColors.zeptaPurple,
        //     unselectedItemColor: AppColors.zeptaGrayscale[20],
        //     type: BottomNavigationBarType.fixed,
        //     onTap: (index) {
        //       didSelectTab(Tabs.values.toList()[index]);
        //     },
        //     items: Tabs.values.map((tab) => _buildItem(tab, context)).toList()),
        );
  }

  // BottomNavigationBarItem _buildItem(Tabs tab, BuildContext context) {
  //   return BottomNavigationBarItem(
  //       icon: SvgPicture.asset(
  //         currentTab == tab ? tab.selectedIcon : tab.unSelectedIcon,
  //       ),
  //       label: tab.name);
  // }

  // activeTextStyle() => TextStyle(
  //       fontFamily: FontFamily.plusJakartaSans,
  //       fontSize: 12.sp,
  //       color: AppColors.zeptaPurple,
  //       fontWeight: FontWeight.w600,
  //     );
  // inActiveTextStyle() => TextStyle(
  //       fontFamily: FontFamily.plusJakartaSans,
  //       fontSize: 12.sp,
  //       color: AppColors.zeptaGrayscale[20],
  //       fontWeight: FontWeight.w600,
  //     );
}
