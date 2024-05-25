import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Screens/Home/Widgets/title_view_all_widget.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class OffersSliderWidget extends StatefulWidget {
  const OffersSliderWidget({
    super.key,
  });

  @override
  State<OffersSliderWidget> createState() => _OffersSliderWidgetState();
}

class _OffersSliderWidgetState extends State<OffersSliderWidget> {
  int activeIndex = 0;

  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWithViewAllWidget(
            title: "Offers".tr(context),
            onTap: () {
              // GeneralRoute.navigatorPushWithContext(
              //     context, AllChampionshipScreen());
            }),
        SizedBox(
          height: 1.h,
        ),
        CarouselSlider.builder(
            carouselController: carouselController,
            itemCount: 3,
            itemBuilder: (context, index, realIndex) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // CachedNetworkImage(
                  //   placeholder: (context, url) => Center(
                  //     child: Shimmer.fromColors(
                  //       baseColor:
                  //           AppColors.greyColor.withOpacity(0.5),
                  //       highlightColor: AppColors.greyLightColor,
                  //       child: Container(
                  //         width: double.infinity,
                  //         decoration: BoxDecoration(
                  //           color: Theme.of(context).primaryColor,
                  //           borderRadius: BorderRadius.circular(4.w),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  //   imageBuilder: (context, imageProvider) =>
                  //       Container(
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //       color: Theme.of(context).primaryColor,
                  //       borderRadius: BorderRadius.circular(4.w),
                  //       image: DecorationImage(
                  //           image: imageProvider, fit: BoxFit.cover),
                  //     ),
                  //   ),
                  //   fadeInDuration: const Duration(milliseconds: 4),
                  //   fadeOutDuration: const Duration(milliseconds: 4),
                  //   imageUrl: widget
                  //           .championshipBloc
                  //           .allChampionShipsModel!
                  //           .data!
                  //           .championship![index]
                  //           .image ??
                  //       "",
                  //   errorWidget: (context, url, error) => Container(
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //       color: Theme.of(context).primaryColor,
                  //       borderRadius: BorderRadius.circular(4.w),
                  //       image: const DecorationImage(
                  //           image: AssetImage(
                  //               AppAssets.footballChampionshipImage),
                  //           fit: BoxFit.contain),
                  //     ),
                  //   ),
                  //   fit: BoxFit.cover,
                  // ),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(4.w),
                      image: const DecorationImage(
                          image: AssetImage(AppAssets.deviceImage),
                          fit: BoxFit.cover),
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
                                  textData: "New Offer",
                                  textStyle:
                                      Theme.of(context).textTheme.labelMedium,
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
              autoPlay: false,

              viewportFraction: 0.85,

              onPageChanged: (index, reason) {
                return setState(() => activeIndex = index);
              },
            ))
      ],
    );
  }
}
