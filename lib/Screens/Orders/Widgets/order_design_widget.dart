import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Data/Models/orders_model.dart';
import 'package:ecommerce/Screens/Orders/Widgets/order_status_widget.dart';
import 'package:ecommerce/Screens/Orders/Widgets/view_small_images_widget.dart';
import 'package:ecommerce/Screens/Orders/order_details_sceen.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Util/functions.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class OrderDesignWidget extends StatelessWidget {
  final Orders order;

  const OrderDesignWidget({required this.order, super.key});



  @override
  Widget build(BuildContext context) {
    return Card(
      // height: 20.h,
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      color: Theme.of(context).cardColor,
      elevation: 2,

      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      textData: order.dateCreated,
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                    CustomText(
                      textData: order.timeCreated,
                      textStyle: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                orderState(context,status: order.orderStatus!)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ViewSmallImagesWidget(
                  images: order.images!,
                ),
                Column(
                  children: [
                    CustomText(
                      textData: "Total Price".tr(context),
                      textStyle: Theme.of(context).textTheme.headlineMedium,
                    ),
                    CustomText(
                      textData: "${addCommasToNumber(order.totalPrice!)} SYP",
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: SizedBox(
              width: double.infinity,
              child: MaterialButton(
                elevation: 3,
                onPressed: () {
                  GeneralRoute.navigatorPushWithContext(
                      context, OrderDetailsSceen(orderId: order.id!));
                },
                color: Theme.of(context).primaryColor,
                child: Text(
                  "View Order".tr(context),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
