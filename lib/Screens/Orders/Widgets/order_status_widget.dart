  import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget orderState(BuildContext context,{required String status}) {
    if (status== "Picked up") {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.yallowColor,
            ),
            borderRadius: BorderRadius.circular(5.w)),
        child: CustomText(
          textData: "Delivering".tr(context),
          textStyle: TextStyle(
              color: AppColors.yallowColor,
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
        ),
      );
    } else if (status== "Deliverd") {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.greanColor,
            ),
            borderRadius: BorderRadius.circular(5.w)),
        child: CustomText(
          textData: "Delivered".tr(context),
          textStyle: TextStyle(
              color: AppColors.greanColor,
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
        ),
      );
    } else if (status== "Cancelled") {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.redColor),
            borderRadius: BorderRadius.circular(5.w)),
        child: CustomText(
          textData: "Cancelled".tr(context),
          textStyle: TextStyle(
              color: AppColors.redColor,
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(5.w)),
        child: CustomText(
          textData: "Pending".tr(context),
          textStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
        ),
      );
    }
  }