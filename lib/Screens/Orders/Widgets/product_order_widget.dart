import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Data/Models/orders_model.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Util/functions.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:ecommerce/Widgets/view_images_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:sizer/sizer.dart';

class ProductOrderWidget extends StatefulWidget {
  final Order order;
  const ProductOrderWidget({required this.order, super.key});

  @override
  State<ProductOrderWidget> createState() => _ProductOrderWidgetState();
}

class _ProductOrderWidgetState extends State<ProductOrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      margin: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
      color: Theme.of(context).cardColor,
      child: Row(
        children: [
          CachedNetworkImage(
            placeholder: (context, url) => Center(
              child: Shimmer.fromColors(
                baseColor: AppColors.greyColor.withOpacity(0.5),
                highlightColor: AppColors.greyLightColor,
                child: Container(
                  height: 20.h,
                  width: 40.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            imageBuilder: (context, imageProvider) => InkWell(
                onTap: () {
                  GeneralRoute.navigatorPushWithContext(
                      context,
                      ViewImagesWidget(
                        image: widget.order.products!.product!.mainImage,
                      ));
                },
                child: Image(height: 20.h, width: 40.w, image: imageProvider)),
            fadeInDuration: const Duration(milliseconds: 4),
            fadeOutDuration: const Duration(milliseconds: 4),
            imageUrl: widget.order.products!.product!.mainImage ?? '',
            errorWidget: (context, url, error) => Container(
              height: 20.h,
              width: 40.w,
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
            width: 1.w,
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                          textData: widget.order.products!.product!.name,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                          textStyle:
                              Theme.of(context).textTheme.headlineMedium),
                    ),
                  ],
                ),
                Row(
                  children: [
                    widget.order.products!.size != null
                        ? CustomText(
                            textData: widget.order.products!.size!,
                            textStyle:
                                Theme.of(context).textTheme.headlineSmall,
                          )
                        : const SizedBox(),
                    widget.order.products!.color != null
                        ? Container(
                            height: 2.h,
                            width: 6.w,
                            margin: EdgeInsets.symmetric(horizontal: 2.w),
                            decoration: BoxDecoration(
                              color: Color(
                                  colorParseInt(widget.order.products!.color!)),
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).focusColor),
                              shape: BoxShape.circle,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CustomText(
                                textData:
                                    "${addCommasToNumber(widget.order.products!.price!)} SYP",
                                textStyle: TextStyle(
                                    decorationColor: AppColors.redColor,
                                    decoration:
                                        widget.order.products!.salePrice! != 0
                                            ? TextDecoration.lineThrough
                                            : null,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .color,
                                    fontWeight: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .fontWeight,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .fontSize),
                              ),
                              if (widget.order.products!.salePrice != 0)
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.w),
                                  child: CustomText(
                                      textAlign: TextAlign.start,
                                      textData:
                                          "${((1 - (widget.order.products!.salePrice! / widget.order.products!.price!)) * 100).round()}%",
                                      textStyle: TextStyle(
                                        color: AppColors.redColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.sp,
                                      )),
                                ),
                            ],
                          ),
                          if (widget.order.products!.salePrice != 0)
                            Row(
                              children: [
                                CustomText(
                                    textData:
                                        "${addCommasToNumber(widget.order.products!.salePrice!)} SYP",
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                        textData: "Quantity".tr(context),
                        textStyle: Theme.of(context).textTheme.headlineSmall),
                    SizedBox(
                      width: 2.w,
                    ),
                    Expanded(
                      child: CustomText(
                          textData: "${widget.order.quantity!}",
                          textAlign: TextAlign.start,
                          textStyle: Theme.of(context).textTheme.headlineSmall),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
