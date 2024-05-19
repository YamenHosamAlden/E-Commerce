import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Widgets/custom_button.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';


import 'package:sizer/sizer.dart';

Future showConfirmDialog(BuildContext context,
    {required String title, required Function onPressed}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            scrollable: true,
            title: CustomText(
              textData: title,
              textAlign: TextAlign.center,
            
            ),
            actionsPadding:
                EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              CustomButton(
                onPressed: () {
                  GeneralRoute.navigatorPobWithContext(context);
                  onPressed();
                },
                textColor: AppColors.textFieldColor,
                buttonText: "Yes".tr(context),
              ),
              SizedBox(
                height: 1.h,
              ),
              CustomButton(
                onPressed: () {
                  GeneralRoute.navigatorPobWithContext(context);
                },
                textColor: AppColors.textFieldColor,
                buttonText: "No".tr(context),
              ),
            ],
          ));
}
