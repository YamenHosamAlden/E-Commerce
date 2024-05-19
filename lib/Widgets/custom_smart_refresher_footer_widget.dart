import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

class CustomSmartRefresherFooterWidget extends StatelessWidget {
  const CustomSmartRefresherFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (context, mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Divider(
                thickness: 0.5,
                color: AppColors.greyLightColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Pull up".tr(context),
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                  Icon(
                    Icons.arrow_upward,
                    color: Theme.of(context).primaryColor,
                    size: 15.sp,
                  ),
                ],
              ),
            ],
          );
        } else if (mode == LoadStatus.loading) {
          body = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Divider(
                thickness: 0.5,
                color: AppColors.greyLightColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Loading more...".tr(context),
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(
                    height: 3.h,
                    width: 6.w,
                    child:  LoadingIndicator(
                        indicatorType: Indicator.ballRotateChase,
                        colors: [Theme.of(context).primaryColor],
                        strokeWidth: 4,
                        backgroundColor: Colors.transparent,
                        pathBackgroundColor: Colors.transparent),
                  ),
                ],
              ),
            ],
          );
        } else if (mode == LoadStatus.failed) {
          body = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Divider(
                thickness: 0.5,
                color: AppColors.greyLightColor,
              ),
              CustomText(
                textData: "Load failed".tr(context),
              ),
            ],
          );
        } else if (mode == LoadStatus.canLoading) {
          body = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Divider(
                thickness: 0.5,
                color: AppColors.greyLightColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Pull up".tr(context),
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                  Icon(
                    Icons.arrow_upward,
                    color: Theme.of(context).primaryColor,
                    size: 15.sp,
                  ),
                ],
              ),
            ],
          );
        } else if (mode == LoadStatus.noMore) {
          body = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Divider(
                thickness: 0.5,
                color: AppColors.greyLightColor,
              ),
              CustomText(
                textData: "No more".tr(context),
              ),
            ],
          );
        } else {
          body = const SizedBox();
        }
        return SizedBox(
          height: 5.h,
          child: Center(child: body),
        );
      },
    );
  }
}
