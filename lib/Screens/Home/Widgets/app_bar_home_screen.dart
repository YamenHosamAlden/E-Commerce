import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

PreferredSizeWidget appBarHomeScreenWidget(BuildContext context,
    {required String title, GlobalKey<ScaffoldState>? scaffoldKey}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(AppBar().preferredSize.height),
    child: AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () {
          scaffoldKey!.currentState!.openDrawer();
        },
        icon: ImageIcon(
          const AssetImage(AppAssets.sideBarIcon),
          size: 8.w,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
      title: CustomText(
        textData: title,
        textStyle: Theme.of(context).textTheme.headlineLarge,

        // textColor: Theme.of(context).primaryColor,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: ImageIcon(
            const AssetImage(AppAssets.notificationIcon),
            size: 8.w,
            color: Theme.of(context).iconTheme.color,
          ),
        )
      ],
    ),
  );
}
