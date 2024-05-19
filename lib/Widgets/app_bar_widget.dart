import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

PreferredSizeWidget appBarWidget(BuildContext context,
    {required String title,
    bool buttonBack = true,
    GlobalKey<ScaffoldState>? scaffoldKey}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(AppBar().preferredSize.height),
    child: AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: buttonBack
          ? InkWell(
              onTap: () {
                GeneralRoute.navigatorPobWithContext(context);
              },
              child: Icon(
                Icons.arrow_back_outlined,
                color: Theme.of(context).iconTheme.color,
                size: 8.w,
              ))
          : scaffoldKey != null
              ? IconButton(
                  onPressed: () {
                    scaffoldKey.currentState!.openDrawer();
                  },
                  icon: ImageIcon(
                    const AssetImage(AppAssets.sideBarIcon),
                    size: 8.w,
                    color: Theme.of(context).iconTheme.color,
                  ),
                )
              : null,
      title: CustomText(
        textData: title,
        textStyle: Theme.of(context).textTheme.headlineLarge,

        // textColor: Theme.of(context).primaryColor,
      ),
    ),
  );
}
