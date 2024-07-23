import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/profile_bloc/profile_bloc.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Screens/Account/Widgets/avatar_info_widget.dart';
import 'package:ecommerce/Screens/Account/edit_profile_screen.dart';
import 'package:ecommerce/Widgets/menu_item.dart';
import 'package:ecommerce/Screens/Products/favorite_screen.dart';
import 'package:ecommerce/Screens/Orders/orders_screen.dart';
import 'package:ecommerce/Util/Dialogs/localization_pop_up.dart';
import 'package:ecommerce/Util/Dialogs/theme_pop_up.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late ProfileBloc profileBloc;
  @override
  void initState() {
    super.initState();
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(GetProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
            child: SingleChildScrollView(
                child: Column(children: [
      AvatarInfoWidget(profileBloc: profileBloc),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.5.w),
        child: Divider(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      MenuItemm(
        onPressed: () {
          GeneralRoute.navigatorPushWithContext(context, EditProfileScreen());
        },
        image: AppAssets.basicInfoIcon,
        title: "Profile".tr(context),
      ),
      MenuItemm(
        onPressed: () {
          GeneralRoute.navigatorPushWithContext(
              context, const FavoriteScreen());
        },
        image: AppAssets.heartIcon,
        title: "Favorite".tr(context),
      ),
      MenuItemm(
        onPressed: () {
          GeneralRoute.navigatorPushWithContext(context,  OrdersScreen());
        },
        image: AppAssets.ordersIcon,
        title: "My Orders".tr(context),
      ),
      MenuItemm(
        onPressed: () {
          popUpChooseLocale(context);
        },
        image: AppAssets.langIcon,
        title: "Language".tr(context),
      ),
      MenuItemm(
        onPressed: () {
          popUpChooseTheme(context);
        },
        image: AppAssets.themesIcon,
        title: "Theme".tr(context),
      ),
    ]))));
  }
}
