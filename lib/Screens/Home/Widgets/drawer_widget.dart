import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Screens/Home/Widgets/drawer_item.dart';
import 'package:ecommerce/Screens/Orders/orders_screen.dart';
import 'package:ecommerce/Util/Dialogs/localization_pop_up.dart';
import 'package:ecommerce/Util/Dialogs/theme_pop_up.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Widgets/avatarImage.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
            child: SingleChildScrollView(
                child: Column(children: [
      Column(
        children: [
          const AvatarImage(
            editButton: false,
            stringImage: "",
          ),
          CustomText(
            textData: "My Name",
            textStyle: Theme.of(context).textTheme.headlineMedium,
          )
        ],
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.5.w),
        child: Divider(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      DrawerItem(
        onTap: () {},
        icon: AppAssets.profileIcon,
        textStyle: Theme.of(context).textTheme.bodyLarge,
        title: "Profile".tr(context),
      ),
      DrawerItem(
        onTap: () {
         
        },
        icon: AppAssets.heartIcon,
        textStyle: Theme.of(context).textTheme.bodyLarge,
        title: "Favorite".tr(context),
      ),
      DrawerItem(
        onTap: () {
          GeneralRoute.navigatorPushWithContext(context, const OrdersScreen());
        },
        icon: AppAssets.ordersIcon,
        textStyle: Theme.of(context).textTheme.bodyLarge,
        title: "My Orders".tr(context),
      ),
      DrawerItem(
        onTap: () {
          popUpChooseLocale(context);
        },
        icon: AppAssets.langIcon,
        textStyle: Theme.of(context).textTheme.bodyLarge,
        title: "Language".tr(context),
      ),
      DrawerItem(
        onTap: () {
          popUpChooseTheme(context);
        },
        icon: AppAssets.themesIcon,
        textStyle: Theme.of(context).textTheme.bodyLarge,
        title: "Theme".tr(context),
      ),
    ]))));
  }
}
