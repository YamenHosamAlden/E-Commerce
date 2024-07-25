import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/auth_bloc/auth_bloc.dart';
import 'package:ecommerce/Bloc/main_bloc/main_bloc.dart';
import 'package:ecommerce/Bloc/profile_bloc/profile_bloc.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Screens/Account/Widgets/avatar_info_widget.dart';
import 'package:ecommerce/Screens/Account/delivery_addreeses_screen.dart';
import 'package:ecommerce/Screens/Account/edit_profile_screen.dart';
import 'package:ecommerce/Screens/Account/theme_screen.dart';
import 'package:ecommerce/Screens/Orders/orders_screen.dart';
import 'package:ecommerce/Screens/Products/favorite_screen.dart';
import 'package:ecommerce/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:ecommerce/Widgets/menu_item.dart';
import 'package:ecommerce/Screens/Account/change_password_screen.dart';
import 'package:ecommerce/Screens/Account/language_screen.dart';
import 'package:ecommerce/Screens/Splash/splash_screen.dart';
import 'package:ecommerce/Util/Dialogs/confirm_dialog.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Util/functions.dart';
import 'package:ecommerce/Widgets/custom_smart_refrecher_header_widget.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  RefreshController refreshController = RefreshController();
  late ProfileBloc profileBloc;
  late AuthBloc authBloc;
  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    profileBloc = BlocProvider.of<ProfileBloc>(context);

    profileBloc.add(GetProfileEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SmartRefresher(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        controller: refreshController,
        onRefresh: () {
          profileBloc.add(GetProfileEvent());
          refreshController.refreshCompleted();
        },
        header: const CustomSmartRefrecherHeaderWidget(),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 4.h,
            ),
            AvatarInfoWidget(
              profileBloc: profileBloc,
            ),
            MenuItemm(
              title: "Profile".tr(context),
              onPressed: () {
                GeneralRoute.navigatorPushWithContext(
                    context, EditProfileScreen());
              },
              image: AppAssets.basicInfoIcon,
            ),
            MenuItemm(
              title: "Delivery addresses".tr(context),
              onPressed: () {
                GeneralRoute.navigatorPushWithContext(
                    context, DeliveryAddreesesScreen());
              },
              image: AppAssets.locationIcon,
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
                GeneralRoute.navigatorPushWithContext(context, OrdersScreen());
              },
              image: AppAssets.ordersIcon,
              title: "My Orders".tr(context),
            ),
            MenuItemm(
              title: "Language".tr(context),
              onPressed: () {
                GeneralRoute.navigatorPushWithContext(
                    context, const LanguageScreen());
              },
              image: AppAssets.langIcon,
            ),
            MenuItemm(
              title: "Theme".tr(context),
              onPressed: () {
                GeneralRoute.navigatorPushWithContext(
                    context, const ThemeScreen());
              },
              image: AppAssets.themesIcon,
            ),
            MenuItemm(
              title: "Security".tr(context),
              onPressed: () {
                GeneralRoute.navigatorPushWithContext(
                    context, ChangePasswordScreen());
              },
              image: AppAssets.lockIcon,
            ),
            BlocConsumer<AuthBloc, AuthStates>(
              listener: (context, state) {
                if (state is LogOutErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      errorSnackBar(context, message: state.message));
                }
                if (state is LogOutSuccessfulState) {
                  ScaffoldMessenger.of(context).showSnackBar(successSnackBar(
                    context,
                    message: "Log Out successful",
                  ));

                  GeneralRoute.navigatorPushAndRemoveScreensWithoutContext(
                      const SplashScreen());
                  BlocProvider.of<MainBloc>(context)
                      .add(SelectBottomNavigationBarItem(index: 0));
                  AppSharedPreferences.removeToken();
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    MenuItemm(
                      title: "Log Out",
                      onPressed: () {
                        showConfirmDialog(context,
                            title: "Are you sure you want to log out?",
                            onPressed: () {
                          authBloc.add(LogOutEvent());
                        });
                      },
                      image: AppAssets.logoutIcon,
                    ),
                    if (state is LogOutLoadingState)
                      SizedBox(
                          height: 8.h,
                          width: 16.w,
                          child: const LoadingWidget())
                  ],
                );
              },
            )
          ]),
        ),
      )),
    );
  }
}
