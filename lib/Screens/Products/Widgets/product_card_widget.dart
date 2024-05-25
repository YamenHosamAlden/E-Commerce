import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:ecommerce/Widgets/rate_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.w)),
      child: InkWell(
        borderRadius: BorderRadius.circular(4.w),
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // CachedNetworkImage(
            //   placeholder: (context, url) => Center(
            //     child: Shimmer.fromColors(
            //       baseColor: AppColors.greyColor.withOpacity(0.5),
            //       highlightColor: AppColors.greyLightColor,
            //       child: Container(
            //         height: 20.h,
            //         decoration: BoxDecoration(
            //           color: Colors.grey,
            //           borderRadius: BorderRadius.circular(4.w),
            //         ),
            //       ),
            //     ),
            //   ),
            //   imageBuilder: (context, imageProvider) => InkWell(
            //     onTap: () {

            //     },
            //     child: Container(
            //       height: 20.h,
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(4.w),
            //           image: DecorationImage(
            //               image: imageProvider, fit: BoxFit.cover)),
            //     ),
            //   ),
            //   fadeInDuration: const Duration(milliseconds: 4),
            //   fadeOutDuration: const Duration(milliseconds: 4),
            //   imageUrl: team.teamImage!,
            //   errorWidget: (context, url, error) => Container(
            //     height: 20.h,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //       color: AppColors.greyLightColor,
            //       borderRadius: BorderRadius.circular(4.w),
            //       border: Border.all(width: 1, color: AppColors.greyColor),
            //     ),
            //     child: const Image(
            //       image: AssetImage(AppAssets.teamIcon),
            //       color: Theme.of(context).primaryColor,
            //       fit: BoxFit.contain,
            //     ),
            //   ),
            //   fit: BoxFit.cover,
            // ),

            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  height: 20.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.w),
                      image: const DecorationImage(
                          image: AssetImage(AppAssets.deviceImage),
                          fit: BoxFit.cover)),
                ),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          Theme.of(context).iconTheme.color!.withOpacity(0.5)),
                  child: IconButton(
                      onPressed: () {},
                      icon: Image(
                        image: const AssetImage(AppAssets.heartOutIcon),
                        color: AppColors.redColor,
                        height: 3.h,
                        width: 6.w,
                      )),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            textData: "Product name",
                            textStyle: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 2,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [RateWidget(numberOfStar: 0.7),CustomText(textData: "500",)],
                    ),
                    Row(
                      children: [
                        CustomText(
                          textData: "Code : ".tr(context),
                          textStyle: Theme.of(context).textTheme.bodySmall,
                        ),
                        Expanded(
                          child: CustomText(
                            textAlign: TextAlign.start,
                            textData: "01921233",
                            textStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Row(
                      children: [
                        CustomText(
                          textData: "Price : ".tr(context),
                          textStyle: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Expanded(
                          child: CustomText(
                            textAlign: TextAlign.start,
                            textData: "50\$",
                            textStyle: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).iconTheme.color),
                          child: IconButton(
                              onPressed: () {},
                              icon: Image(
                                image: const AssetImage(AppAssets.cartIcon),
                                color: Theme.of(context).primaryColor,
                                height: 3.h,
                                width: 6.w,
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
