import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget deliveryType(BuildContext context, {required String type}) {
  if (type == "TRUCK") {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(5.w)),
      child: Row(
        children: [
          CustomText(
            textData: "Truck".tr(context),
            textStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
          ),
          SizedBox(
            width: 2.w,
          ),
          Image(
              height: 4.h,
              width: 8.w,
              color: Theme.of(context).primaryColor,
              image: const AssetImage(AppAssets.truckIcon))
        ],
      ),
    );
  } else if (type == "CAR") {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(5.w)),
      child: Row(
        children: [
          CustomText(
            textData: "Car".tr(context),
            textStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                   fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
          ),
          SizedBox(
            width: 2.w,
          ),
          Image(
              height: 4.h,
              width: 8.w,
              color: Theme.of(context).primaryColor,
              image: const AssetImage(AppAssets.carIcon))
        ],
      ),
    );
  } else {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(5.w)),
      child: Row(
        children: [
          CustomText(
            textData: "Motocycle".tr(context),
            textStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
          ),
          SizedBox(
            width: 2.w,
          ),
          Image(
              height: 4.h,
              width: 8.w,
              color: Theme.of(context).primaryColor,
              image: const AssetImage(AppAssets.bickeIcon))
        ],
      ),
    );
  }
}
