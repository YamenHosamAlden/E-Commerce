import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/products_bloc/products_bloc.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Screens/Promotion/products_promotion_screen.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Widgets/app_bar_widget.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:ecommerce/Widgets/error_message_widget.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class PromotionsScreen extends StatefulWidget {
  const PromotionsScreen({super.key});

  @override
  State<PromotionsScreen> createState() => _PromotionsScreenState();
}

class _PromotionsScreenState extends State<PromotionsScreen> {
  final ProductsBloc productsBloc = ProductsBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => productsBloc..add(GetPromotionsEvent()),
      child: Scaffold(
        appBar: appBarWidget(context, title: "Offers".tr(context)),
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is GetProductListErrorState) {
              return ErrorMessageWidget(
                  message: state.message,
                  onPressed: () {
                    productsBloc.add(GetPromotionsEvent());
                  });
            }

            if (state is GetProductListLoadingState ||
                state is ProductsInitial) {
              return const LoadingWidget();
            }
            return ListView.builder(
              itemCount: productsBloc.promotionModel!.promotion!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      InkWell(
                        onTap: () {
                          GeneralRoute.navigatorPushWithContext(
                              context,
                              ProductsPromotionScreen(
                                promotionId: productsBloc
                                    .promotionModel!.promotion![index].id!,
                                title: productsBloc
                                    .promotionModel!.promotion![index].name!,
                              ));
                        },
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Center(
                            child: Shimmer.fromColors(
                              baseColor: AppColors.greyColor.withOpacity(0.5),
                              highlightColor: AppColors.greyLightColor,
                              child: Container(
                                height: 20.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(4.w),
                                ),
                              ),
                            ),
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            height: 20.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              // color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(4.w),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          fadeInDuration: const Duration(milliseconds: 4),
                          fadeOutDuration: const Duration(milliseconds: 4),
                          imageUrl: productsBloc
                              .promotionModel!.promotion![index].imageUrl!,
                          errorWidget: (context, url, error) => Container(
                            height: 20.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(4.w),
                              image: const DecorationImage(
                                  image:
                                      AssetImage(AppAssets.profileCircleImage),
                                  fit: BoxFit.contain),
                            ),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 2.w),
                            decoration: BoxDecoration(
                                color: AppColors.blackColor.withOpacity(0.5),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(
                                      4.w,
                                    ),
                                    bottomRight: Radius.circular(4.w))),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                      textData: productsBloc.promotionModel!
                                          .promotion![index].name,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
