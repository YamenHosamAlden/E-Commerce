import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Data/Models/categories_model.dart';
import 'package:ecommerce/Screens/Categories/sub_categories_screen.dart';
import 'package:ecommerce/Screens/Products/products_screen.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:sizer/sizer.dart';

class CardCategoryWidget extends StatelessWidget {
  final Categories categories;
  final int titleMaxLine;

  const CardCategoryWidget(
      {required this.categories, this.titleMaxLine = 3, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25.w,
      child: InkWell(
        borderRadius: BorderRadius.circular(5.w),
        onTap: () {
          if (categories.isLeaf!) {
            GeneralRoute.navigatorPushWithContext(
                context,
                ProductsScreen(
                  slug: categories.slug!,
                  categoryName: categories.name!,
                ));
          } else {
            GeneralRoute.navigatorPushWithContext(
                context,
                SubCategoriesScreen(
                  slug: categories.slug!,
                  categoryName: categories.name!,
                ));
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 0.5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                placeholder: (context, url) => Center(
                  child: Shimmer.fromColors(
                    baseColor: AppColors.greyColor.withOpacity(0.5),
                    highlightColor: AppColors.greyLightColor,
                    child: Container(
                      height: 9.h,
                      width: 18.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                imageBuilder: (context, imageProvider) => Container(
                  height: 9.h,
                  width: 18.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
                fadeInDuration: const Duration(milliseconds: 4),
                fadeOutDuration: const Duration(milliseconds: 4),
                imageUrl: categories.imageUrl!,
                errorWidget: (context, url, error) => Container(
                  color: Theme.of(context).cardColor,
                  height: 9.h,
                  width: 18.w,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image(
                    image: const AssetImage(AppAssets.fallImage),
                    color: Theme.of(context).primaryColor,
                    fit: BoxFit.contain,
                  ),
                ),
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: CustomText(
                  textData: categories.name,
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
