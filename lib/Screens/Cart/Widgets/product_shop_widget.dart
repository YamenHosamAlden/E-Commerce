import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class ProductShopWidget extends StatelessWidget {
  const ProductShopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
      color: Theme.of(context).cardColor,
      child: Row(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                textData: "name",
                textStyle: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 16.sp),
              ),
              SizedBox(
                height: 1.h,
              ),
              CustomText(
                  textData: "500",
                  textStyle: Theme.of(context).textTheme.bodyMedium),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.w),
                      color: Theme.of(context).primaryColor,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.add,
                        size: 16.sp,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  CustomText(
                      textData: "5",
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium),
                  SizedBox(
                    width: 2.w,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.w),
                      color: Theme.of(context).primaryColor,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.remove,
                        size: 16.sp,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
          Image(
            height: 20.h,
            width: 40.w,
            image: const AssetImage(
              AppAssets.slaeImage,
            ),
            // color: AppColors.primaryColor,
            //
          ),
        ],
      ),
    );
  }
}
