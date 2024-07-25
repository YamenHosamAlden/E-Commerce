import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Data/Models/product_model.dart';
import 'package:ecommerce/Screens/Products/Widgets/add_to_cart_button_widget.dart';
import 'package:ecommerce/Screens/Products/Widgets/favorite_button_widget.dart';
import 'package:ecommerce/Screens/Products/product_details_screen.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Util/functions.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ProductCardWidget extends StatelessWidget {
  final Product? product;
  final ProductModel? productModel;
  final bool favoriteScreen;
  const ProductCardWidget(
      {super.key,
      this.product,
      this.productModel,
      this.favoriteScreen = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.w,
      child: Card(
        color: Theme.of(context).cardColor,
        margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.w)),
        child: InkWell(
          borderRadius: BorderRadius.circular(4.w),
          onTap: () {
            GeneralRoute.navigatorPushWithContext(
                context,
                ProductDetailsScreen(
                  productName: product!.name!,
                  slug: product!.slug!,
                ));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 20.h,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      placeholder: (context, url) => Center(
                        child: Shimmer.fromColors(
                          baseColor: AppColors.greyColor.withOpacity(0.5),
                          highlightColor: AppColors.greyLightColor,
                          child: Container(
                            height: 20.h,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(4.w),
                            ),
                          ),
                        ),
                      ),
                      imageBuilder: (context, imageProvider) => Container(
                        height: 20.h,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.w),
                        ),
                        child: Image(
                          image: imageProvider,
                          fit: BoxFit.contain,
                        ),
                      ),
                      fadeInDuration: const Duration(milliseconds: 4),
                      fadeOutDuration: const Duration(milliseconds: 4),
                      imageUrl: product!.mainImage!,
                      errorWidget: (context, url, error) => Container(
                        height: 20.h,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(4.w),
                          border:
                              Border.all(width: 1, color: AppColors.greyColor),
                        ),
                        child: Image(
                          image: const AssetImage(AppAssets.fallImage),
                          color: Theme.of(context).primaryColor,
                          fit: BoxFit.contain,
                        ),
                      ),
                      fit: BoxFit.cover,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (favoriteScreen) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FavoriteButtonWidget(
                                productDetailId: productModel!.id,
                                inWishList: favoriteScreen,
                              )
                            ],
                          ),
                        ] else ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FavoriteButtonWidget(
                                productId: product!.id,
                                inWishList: product!.inWishList!,
                              )
                            ],
                          ),
                        ],
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AddToCartButtonWidget(
                              productId: product!.id,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
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
                              textData: product!.name,
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CustomText(
                            textData: product!.averageRating.toString(),
                            textStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                          Icon(
                            Icons.star,
                            color: Theme.of(context).primaryColor,
                            size: 5.w,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          CustomText(
                            textData: product!.reviewsCount.toString(),
                            textStyle: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     CustomText(
                      //       textData: "Code : ".tr(context),
                      //       textStyle: Theme.of(context).textTheme.bodySmall,
                      //     ),
                      //     Expanded(
                      //       child: CustomText(
                      //         textAlign: TextAlign.start,
                      //         textData: "01921233",
                      //         textStyle: Theme.of(context).textTheme.bodySmall,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Divider(
                        color: Theme.of(context).colorScheme.secondary,
                      ),

                      Row(
                        children: [
                          if (productModel?.size != null)
                            CustomText(
                              textAlign: TextAlign.start,
                              textData: productModel!.size!,
                              textStyle: Theme.of(context).textTheme.bodySmall,
                            ),
                          SizedBox(
                            width: 2.w,
                          ),
                          if (productModel?.color != null)
                            Container(
                              height: 1.5.h,
                              width: 3.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color:
                                    Color(colorParseInt(productModel!.color!)),
                                border: Border.all(
                                    width: 1,
                                    color: Theme.of(context).focusColor),
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: priceHandel(context)),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget priceHandel(BuildContext context) {
    if (productModel != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomText(
                  textAlign: TextAlign.start,
                  textData: "${addCommasToNumber(productModel!.price!)} SYP",
                  textStyle: TextStyle(
                    decoration: productModel!.salePrice != 0
                        ? TextDecoration.lineThrough
                        : null,
                    decorationColor: AppColors.redColor,
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                  )),
              if (productModel!.salePrice != 0)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: CustomText(
                      textAlign: TextAlign.start,
                      textData:
                          "${((1 - (productModel!.salePrice! / productModel!.price!)) * 100).round()}%",
                      textStyle: TextStyle(
                        color: AppColors.redColor,
                        fontSize:
                            Theme.of(context).textTheme.bodySmall!.fontSize,
                      )),
                ),
            ],
          ),
          if (productModel!.salePrice != 0)
            CustomText(
                textAlign: TextAlign.start,
                textData: "${addCommasToNumber(productModel!.salePrice!)} SYP",
                textStyle: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                )),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomText(
                  textAlign: TextAlign.start,
                  textData: "${addCommasToNumber(product!.mainPrice!)} SYP",
                  textStyle: TextStyle(
                    decoration: product!.mainSalePrice != 0
                        ? TextDecoration.lineThrough
                        : null,
                    decorationColor: AppColors.redColor,
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                  )),
              if (product!.mainSalePrice != 0)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: CustomText(
                      textAlign: TextAlign.start,
                      textData:
                          "${((1 - (product!.mainSalePrice! / product!.mainPrice!)) * 100).round()}%",
                      textStyle: TextStyle(
                        color: AppColors.redColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.sp,
                      )),
                ),
            ],
          ),
          if (product!.mainSalePrice != 0)
            CustomText(
                textAlign: TextAlign.start,
                textData: "${addCommasToNumber(product!.mainSalePrice!)} SYP",
                textStyle: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                )),
        ],
      );
    }
  }
}
