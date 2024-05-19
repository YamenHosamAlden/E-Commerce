import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:sizer/sizer.dart';

showLoaderDialog(BuildContext context) {
  AlertDialog alertDialog = AlertDialog(
    content: Row(
      children: [
        SizedBox(
          height: 5.h,
          width: 10.w,
          child:  LoadingIndicator(
              indicatorType: Indicator.ballRotateChase,
              colors: [
                Theme.of(context).primaryColor,
                AppColors.redColor,
              ],
              strokeWidth: 4,
              backgroundColor: Colors.transparent,
              pathBackgroundColor: Colors.transparent),
        ),
        SizedBox(
          width: 2.w,
        ),
        CustomText(
          textData: "Loading...".tr(context),
        )
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return alertDialog;
    },
  );
}
