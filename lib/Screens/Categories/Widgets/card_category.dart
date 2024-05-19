import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Data/Models/categories_model.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class CardCategoryWidget extends StatelessWidget {
  final CategoriesModel categoriesModel;
  final int titleMaxLine;

  const CardCategoryWidget(
      {required this.categoriesModel, this.titleMaxLine = 3, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28.w,
      child: InkWell(
        borderRadius: BorderRadius.circular(5.w),
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 0.5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 9.h,
                width: 18.w,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(AppAssets.deviceImage),
                        fit: BoxFit.cover)),
              ),

              // CachedNetworkImage(
              //   placeholder: (context, url) => Center(
              //     child: Shimmer.fromColors(
              //       baseColor: AppColors.greyColor.withOpacity(0.5),
              //       highlightColor: AppColors.greyLightColor,
              //       child: Container(
              //         height: 12.h,
              //         width: 24.w,
              //         decoration: const BoxDecoration(
              //           shape: BoxShape.circle,
              //           color: Colors.grey,
              //         ),
              //       ),
              //     ),
              //   ),
              //   imageBuilder: (context, imageProvider) => InkWell(
              //     onTap: () {
              //       GeneralRoute.navigatorPushWithContext(
              //              type: PageTransitionType.fade,
              //         context,
              //         ViewImagesWidget(
              //           image: player.image!,
              //         ),
              //       );
              //     },
              //     child: Container(
              //       height: 12.h,
              //       width: 24.w,
              //       decoration: BoxDecoration(
              //           shape: BoxShape.circle,
              //           image: DecorationImage(
              //               image: imageProvider, fit: BoxFit.cover)),
              //     ),
              //   ),
              //   fadeInDuration: const Duration(milliseconds: 4),
              //   fadeOutDuration: const Duration(milliseconds: 4),
              //   imageUrl: player.image!,
              //   errorWidget: (context, url, error) => Container(
              //     height: 12.h,
              //     width: 24.w,
              //     decoration: const BoxDecoration(
              //       shape: BoxShape.circle,
              //     ),
              //     child: const Image(
              //       image: AssetImage(AppAssets.profileCircleImage),
              //       color: Theme.of(context).primaryColor,
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              //   fit: BoxFit.cover,
              // ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: CustomText(
                  textData: categoriesModel.name,
                  maxLines: titleMaxLine,
                  textOverflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  textStyle: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
