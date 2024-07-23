import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Data/Models/addrees_model.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CardAddreesWidget extends StatelessWidget {
  final AddreesModel addreesModel;
  final Function deleteFun;

  const CardAddreesWidget({
    required this.addreesModel,
    required this.deleteFun,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.w),
          side: BorderSide(
              width: 2,
              color: addreesModel.selected!
                  ? Theme.of(context).primaryColor
                  : Colors.transparent)),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    deleteFun();
                  },
                  icon: (Icon(
                    Icons.delete,
                    color: AppColors.redColor,
                    size: 8.w,
                  ))),
            ],
          ),
          Row(
            children: [
              Image(
                image: const AssetImage(AppAssets.mapIcon),
                height: 20.h,
                width: 30.w,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image(
                            color: Theme.of(context).primaryColor,
                            image: const AssetImage(AppAssets.addressIcon),
                            height: 3.h,
                            width: 6.w,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Expanded(
                            child: CustomText(
                              textData: addreesModel.addressName,
                              textAlign: TextAlign.start,
                              textOverflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Image(
                            color: Theme.of(context).primaryColor,
                            image: const AssetImage(AppAssets.cityIcon),
                            height: 3.h,
                            width: 6.w,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Expanded(
                            child: CustomText(
                              textData: addreesModel.city,
                              textAlign: TextAlign.start,
                              textOverflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Image(
                            color: Theme.of(context).primaryColor,
                            image: const AssetImage(AppAssets.locationIcon),
                            height: 3.h,
                            width: 6.w,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Expanded(
                            child: CustomText(
                              textData: addreesModel.district,
                              textAlign: TextAlign.start,
                              textOverflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Image(
                            color: Theme.of(context).primaryColor,
                            image: const AssetImage(AppAssets.roadIcon),
                            height: 3.h,
                            width: 6.w,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Expanded(
                            child: CustomText(
                              textData: addreesModel.details,
                              textAlign: TextAlign.start,
                              textOverflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
