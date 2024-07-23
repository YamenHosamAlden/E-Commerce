import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/products_bloc/products_bloc.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Screens/Products/Widgets/add_to_cart_button_widget.dart';
import 'package:ecommerce/Screens/Products/Widgets/reviews_widget.dart';
import 'package:ecommerce/Screens/Products/Widgets/slider_photo_widget.dart';
import 'package:ecommerce/Screens/Products/Widgets/favorite_button_widget.dart';
import 'package:ecommerce/Screens/Products/Widgets/select_color_widget.dart';
import 'package:ecommerce/Screens/Products/Widgets/select_size_widget.dart';
import 'package:ecommerce/Util/functions.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';

import 'package:ecommerce/Widgets/app_bar_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productName;
  final String slug;
  const ProductDetailsScreen({
    super.key,
    required this.productName,
    required this.slug,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductsBloc productsBloc = ProductsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          productsBloc..add(GetProductDetailsEvent(slug: widget.slug)),
      child: Scaffold(
        appBar: appBarWidget(context, title: widget.productName),
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is GetProductDetailsErrorState) {
              return const SizedBox();
            }
            if (state is GetProductDetailsLoadingState ||
                state is ProductsInitial) {
              return const LoadingWidget();
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                    color: Theme.of(context).cardColor,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        SliderPhotoWidget(
                            image:
                                productsBloc.productModel!.product!.mainImage,
                            images: productsBloc.productModel!.product!.images!
                                .map((e) => e.imageUrl!)
                                .toList()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Card(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 1.5.w,
                                            vertical: 0.5.h,
                                          ),
                                          child: CustomText(
                                            textData:
                                                "${addCommasToNumber(productsBloc.productDetails!.price!)}SYP",
                                            textStyle: TextStyle(
                                                decoration: productsBloc
                                                            .productDetails!
                                                            .salePrice! !=
                                                        0
                                                    ? TextDecoration.lineThrough
                                                    : null,
                                                decorationColor:
                                                    AppColors.redColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10.sp,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .color),
                                          ),
                                        ),
                                      ),
                                      if (productsBloc
                                              .productDetails!.salePrice! !=
                                          0)
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.w),
                                          child: CustomText(
                                              textAlign: TextAlign.start,
                                              textData:
                                                  "${((1 - (productsBloc.productDetails!.salePrice! / productsBloc.productDetails!.price!)) * 100).round()}%",
                                              textStyle: TextStyle(
                                                color: AppColors.redColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10.sp,
                                              )),
                                        ),
                                    ],
                                  ),
                                  if (productsBloc.productDetails!.salePrice! !=
                                      0)
                                    Card(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 1.5.w,
                                          vertical: 0.5.h,
                                        ),
                                        child: CustomText(
                                          textData:
                                              "${addCommasToNumber(productsBloc.productDetails!.salePrice!)}SYP",
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10.sp,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .color),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: FavoriteButtonWidget(
                                  productDetailId:
                                      productsBloc.productDetails!.id,
                                  inWishList: productsBloc
                                      .productModel!.product!.inWishList!,
                                ),
                              ),
                              Card(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 1.5.w,
                                    vertical: 0.5.h,
                                  ),
                                  child: Row(
                                    children: [
                                      CustomText(
                                        textData:
                                            "${productsBloc.productModel!.product!.averageRating}",
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .color),
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
                                        textData:
                                            "${productsBloc.productModel!.product!.reviewsCount}",
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: Row(
                            children: [
                              CustomText(
                                textData: "Name",
                                textStyle:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomText(
                                  textData:
                                      productsBloc.productModel!.product!.name,
                                  textStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  if (productsBloc
                      .productModel!.product!.colors.isNotEmpty) ...[
                    Container(
                      color: Theme.of(context).cardColor,
                      padding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Row(
                              children: [
                                CustomText(
                                  textData: "Color".tr(context),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ],
                            ),
                          ),
                          SelectColorWidget(
                            colors: productsBloc
                                .productModel!.product!.uniqueColors,
                            selectedColor: (newColor) {
                              productsBloc.add(SwitchProductDetailsEvent(
                                  size: productsBloc.size!, color: newColor));
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                  if (productsBloc.productModel!.product!.sizes.isNotEmpty) ...[
                    Container(
                      color: Theme.of(context).cardColor,
                      padding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Row(
                              children: [
                                CustomText(
                                  textData: "Size".tr(context),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ],
                            ),
                          ),
                          SelectSizeWidget(
                            sizes:
                                productsBloc.productModel!.product!.uniqueSizes,
                            selectedSize: (newSize) {
                              productsBloc.add(SwitchProductDetailsEvent(
                                  size: newSize, color: productsBloc.color!));
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                  Container(
                    color: Theme.of(context).cardColor,
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: Row(
                            children: [
                              CustomText(
                                textData: "Description".tr(context),
                                textStyle:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomText(
                                  textData: productsBloc
                                      .productModel!.product!.description,
                                  textStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  AddToCartButtonWidget(
                    productDeatilId: productsBloc.productDetails!.id,
                    detailsScreen: true,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  ReviewsWidget(
                      reviewSet:
                          productsBloc.productModel!.product!.reviewSet!),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
