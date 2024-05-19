import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Widgets/custom_button.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String message;
  final Function onPressed;

  const ErrorMessageWidget(
      {required this.message, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
          margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(5.w),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 2,
                    blurStyle: BlurStyle.normal,
                    offset: Offset(1, 2),
                    color: AppColors.greyLightColor)
              ]),
          child: Column(
            children: [
              Image(
                image: const AssetImage(AppAssets.logoImage),
                height: 15.h,
                width: 30.w,
              ),
              CustomText(
                textData: message,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomButton(
                  onPressed: () {
                    onPressed();
                  },
                  buttonText: "Try again".tr(context))
            ],
          ),
        ),
      ],
    );
  }
}
