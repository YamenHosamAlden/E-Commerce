import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Screens/Account/delivery_addreeses_screen.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Util/functions.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CompleteOrderWidget extends StatefulWidget {
  final int? totalDiscount;
  final int? userMaxUse;
  final int totalPrice;
  const CompleteOrderWidget(
      {super.key,
      this.totalDiscount,
      this.userMaxUse,
      required this.totalPrice});

  @override
  State<CompleteOrderWidget> createState() => _CompleteOrderWidgetState();
}

class _CompleteOrderWidgetState extends State<CompleteOrderWidget> {
  bool enable = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
                blurRadius: 1,
                spreadRadius: 1,
                color: Theme.of(context).primaryColor)
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.w), topRight: Radius.circular(10.w))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image(
                      height: 3.h,
                      width: 6.w,
                      color: Theme.of(context).primaryColor,
                      image: const AssetImage(AppAssets.discountIcon)),
                  SizedBox(
                    width: 1.w,
                  ),
                  CustomText(
                    textData: "${widget.userMaxUse ?? 0}",
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              SizedBox(
                width: 4.w,
              ),
              Expanded(
                child: Row(
                  children: [
                    CustomText(
                      textData: "Total : ".tr(context),
                      textStyle: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Expanded(
                        child: CustomText(
                      textData: addCommasToNumber(
                          widget.totalPrice - widget.totalDiscount!),
                      textAlign: TextAlign.center,
                      textStyle: Theme.of(context).textTheme.headlineMedium,
                    )),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    enable = !enable;
                  });
                },
                child: Icon(
                  enable ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                  color: Theme.of(context).primaryColor,
                  size: 10.w,
                ),
              ),
            ],
          ),
          if (enable) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              child: Row(
                children: [
                  Expanded(
                      child: CustomText(
                    textData: "Sub-Total : ".tr(context),
                    textStyle: Theme.of(context).textTheme.headlineMedium,
                  )),
                  Expanded(
                      child: CustomText(
                    textData: addCommasToNumber(widget.totalPrice),
                    textStyle: Theme.of(context).textTheme.headlineMedium,
                  )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              child: Row(
                children: [
                  Expanded(
                      child: CustomText(
                    textData: "Discount Coupon : ".tr(context),
                    textStyle: Theme.of(context).textTheme.headlineMedium,
                  )),
                  Expanded(
                      child: CustomText(
                    textData: addCommasToNumber(widget.totalDiscount!),
                    textStyle: Theme.of(context).textTheme.headlineMedium,
                  )),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).dividerColor,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              child: Row(
                children: [
                  Expanded(
                      child: CustomText(
                    textData: "Total : ".tr(context),
                    textStyle: Theme.of(context).textTheme.headlineMedium,
                  )),
                  Expanded(
                      child: CustomText(
                    textData: addCommasToNumber(
                        widget.totalPrice - widget.totalDiscount!),
                    textStyle: Theme.of(context).textTheme.headlineMedium,
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            InkWell(
              onTap: () {
                GeneralRoute.navigatorPushWithContext(
                    context,
                    DeliveryAddreesesScreen(
                      cartScreen: true,
                      totalCost: widget.totalPrice - widget.totalDiscount!,
                    ));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5.w)),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomText(
                          textAlign: TextAlign.center,
                          textData: "Complete Order".tr(context),
                          textStyle: Theme.of(context).textTheme.labelMedium),
                    ),
                    Icon(
                      Icons.send,
                      color: Theme.of(context).textTheme.labelMedium!.color,
                      size: 5.w,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            )
          ]
        ],
      ),
    );
  }
}
