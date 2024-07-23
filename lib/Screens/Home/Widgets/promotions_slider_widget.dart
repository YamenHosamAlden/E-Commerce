import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Data/Models/promotion_model.dart';
import 'package:ecommerce/Screens/Home/Widgets/title_view_all_widget.dart';
import 'package:ecommerce/Screens/Promotion/products_promotion_screen.dart';
import 'package:ecommerce/Screens/Promotion/promotions_screen.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:sizer/sizer.dart';

class PromotionsSliderWidget extends StatefulWidget {
  final List<Promotion> promotion;
  const PromotionsSliderWidget({
    super.key,
    required this.promotion,
  });

  @override
  State<PromotionsSliderWidget> createState() => _PromotionsSliderWidgetState();
}

class _PromotionsSliderWidgetState extends State<PromotionsSliderWidget> {
  int activeIndex = 0;

  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return widget.promotion.isNotEmpty
        ? Column(
            children: [
              TitleWithViewAllWidget(
                  title: "Offers".tr(context),
                  onTap: () {
                    GeneralRoute.navigatorPushWithContext(
                        context,const  PromotionsScreen());
                  }),
              SizedBox(
                height: 1.h,
              ),
              CarouselSlider.builder(
                  carouselController: carouselController,
                  itemCount: widget.promotion.length,
                  itemBuilder: (context, index, realIndex) {
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        InkWell(
                          onTap: () {
                            GeneralRoute.navigatorPushWithContext(
                                context,
                                ProductsPromotionScreen(
                                  promotionId: widget.promotion[index].id!,
                                  title: widget.promotion[index].name!,
                                ));
                          },
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Center(
                              child: Shimmer.fromColors(
                                baseColor: AppColors.greyColor.withOpacity(0.5),
                                highlightColor: AppColors.greyLightColor,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(4.w),
                                  ),
                                ),
                              ),
                            ),
                            imageBuilder: (context, imageProvider) => Container(
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
                            imageUrl: widget.promotion[index].imageUrl!,
                            errorWidget: (context, url, error) => Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(4.w),
                              ),
                              child: Image(
                                image: const AssetImage(AppAssets.fallImage),
                                color: Theme.of(context).primaryColor,
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
                                        textData: widget.promotion[index].name,
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
                    );
                  },
                  options: CarouselOptions(
                    // scrollPhysics: const NeverScrollableScrollPhysics(),
                    enableInfiniteScroll: false,
                    height: 20.h,
                    enlargeCenterPage: true,
                    autoPlay: true,

                    viewportFraction: 0.9,

                    onPageChanged: (index, reason) {
                      return setState(() => activeIndex = index);
                    },
                  ))
            ],
          )
        : const SizedBox();
  }
}
