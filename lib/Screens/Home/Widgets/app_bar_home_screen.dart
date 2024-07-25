import 'package:ecommerce/Bloc/notification_bloc/notification_bloc.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Screens/Notification/notification_screen.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is GetNotificationsErrorState) {
              return IconButton(
                  onPressed: () {
                    BlocProvider.of<NotificationBloc>(context)
                        .add(GetNotificationsEvent());
                  },
                  icon: Icon(
                    Icons.replay_outlined,
                    color: Theme.of(context).iconTheme.color,
                  ));
            }
            return Stack(
              children: [
                IconButton(
                  onPressed: () {
                    GeneralRoute.navigatorPushWithContext(
                        context, const NotificationScreen());
                  },
                  icon: ImageIcon(
                    const AssetImage(AppAssets.notificationIcon),
                    size: 8.w,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.redColor),
                  child: CustomText(
                    textData:
                        "${BlocProvider.of<NotificationBloc>(context).notificationModel?.isSeens?.length ?? 0}",
                    textStyle: TextStyle(
                        color: AppColors.lightWhiteColor,
                        fontSize:
                            Theme.of(context).textTheme.bodySmall!.fontSize,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            );
          },
        )
      ],
    ),
  );
}
