import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/cart_bloc/cart_bloc.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Data/Models/cart_model.dart';
import 'package:ecommerce/Screens/Cart/Widgets/drop_down_quantity_widget.dart';
import 'package:ecommerce/Util/functions.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import 'package:sizer/sizer.dart';

class ProductShopWidget extends StatefulWidget {
  final Products products;
  final int index;
  const ProductShopWidget(
      {required this.index, required this.products, super.key});

  @override
  State<ProductShopWidget> createState() => _ProductShopWidgetState();
}

class _ProductShopWidgetState extends State<ProductShopWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 23.h,
      margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
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
            imageBuilder: (context, imageProvider) =>
                Image(height: 20.h, width: 40.w, image: imageProvider),
            fadeInDuration: const Duration(milliseconds: 4),
            fadeOutDuration: const Duration(milliseconds: 4),
            imageUrl: widget.products.product!.productDetail!.mainImage ?? '',
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
                          textData:
                              widget.products.product!.productDetail!.name,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                          textStyle:
                              Theme.of(context).textTheme.headlineMedium),
                    ),
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<CartBloc>(context).add(
                              RemoveFormCartListEvent(
                                  productDetailId:
                                      widget.products.product!.id));
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).primaryColor,
                        ))
                  ],
                ),
                Row(
                  children: [
                    widget.products.product!.size != null
                        ? CustomText(
                            textData: widget.products.product!.size!,
                            textStyle:
                                Theme.of(context).textTheme.headlineSmall,
                          )
                        : const SizedBox(),
                    widget.products.product!.color != null
                        ? Container(
                            height: 2.h,
                            width: 6.w,
                            margin: EdgeInsets.symmetric(horizontal: 2.w),
                            decoration: BoxDecoration(
                              color: Color(colorParseInt(
                                  widget.products.product!.color!)),
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
                                    "${addCommasToNumber(widget.products.product!.price!)} SYP",
                                textStyle: TextStyle(
                                  decorationColor: AppColors.redColor,
                                  decoration: widget.products.product!.salePrice! != 0? TextDecoration.lineThrough:null,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .color,
                                        fontWeight: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .fontWeight ,
                                        
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .fontSize),
                              ),
                              if (widget.products.product!.salePrice! != 0)
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.w),
                                  child: CustomText(
                                      textAlign: TextAlign.start,
                                      textData:
                                          "${((1 - (widget.products.product!.salePrice! / widget.products.product!.price!)) * 100).round()}%",
                                      textStyle: TextStyle(
                                        color: AppColors.redColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.sp,
                                      )),
                                ),
                            ],
                          ),
                          if (widget.products.product!.salePrice! != 0)
                            Row(
                              children: [
                                CustomText(
                                    textData:
                                        "${addCommasToNumber(widget.products.product!.salePrice!)} SYP",
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: SizedBox(
                        width: 18.w,
                        child: DropDownQuantityWidget(
                            values: widget.products.product!.productStock,
                            dropdownValue: widget.products.quantity,
                            onChanged: (newQty) {
                              BlocProvider.of<CartBloc>(context).add(
                                  ChangeQtyEvent(
                                      productDetailId:
                                          widget.products.product!.id!,
                                      qty: newQty!));
                            }),
                      ),
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
