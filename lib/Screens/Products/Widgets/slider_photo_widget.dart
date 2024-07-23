import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Widgets/view_images_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import 'package:sizer/sizer.dart';

class SliderPhotoWidget extends StatefulWidget {
  final List<String> images;
  final String? image;
  const SliderPhotoWidget({super.key, required this.images, this.image});

  @override
  State<SliderPhotoWidget> createState() => _SliderPhotoWidgetState();
}

class _SliderPhotoWidgetState extends State<SliderPhotoWidget> {
  int activeIndex = 0;

  CarouselController carouselController = CarouselController();

  // List<String?> getTheImages() {
  //   List<String?> images = widget.images.map((e) => e.imageUrl).toList();
  //   return images;
  // }

  @override
  Widget build(BuildContext context) {
    return widget.images.isNotEmpty
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: Column(
              children: [
                CarouselSlider.builder(
                    carouselController: carouselController,
                    itemCount: widget.images.length,
                    itemBuilder: (context, index, realIndex) {
                      return CachedNetworkImage(
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: AppColors.greyColor.withOpacity(0.5),
                          highlightColor: AppColors.greyColor,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.w),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        imageBuilder: (context, imageProvider) => InkWell(
                          onTap: () {
                            GeneralRoute.navigatorPushWithContext(
                              type: PageTransitionType.fade,
                              context,
                              ViewImagesWidget(
                                image: widget.images[index],
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.w),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                                border: Border.all(color: AppColors.greyColor)),
                            // child: Image(
                            //   image: imageProvider,
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                        ),
                        fadeInDuration: const Duration(milliseconds: 4),
                        fadeOutDuration: const Duration(milliseconds: 4),
                        imageUrl: widget.images[index],
                        errorWidget: (context, url, error) => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.w, vertical: 1.h),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border: Border.all(color: AppColors.greyColor),
                            borderRadius: BorderRadius.circular(4.w),
                          ),
                          child: Image(
                            width: double.infinity,
                            image: const AssetImage(AppAssets.fallImage),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fit: BoxFit.contain,
                          ),
                        ),
                        // fit: BoxFit.cover,
                      );
                    },
                    options: CarouselOptions(
                      // scrollPhysics: const NeverScrollableScrollPhysics(),
                      enableInfiniteScroll: false,
                      height: 25.h,
                      enlargeCenterPage: true,
                      autoPlay: false,

                      viewportFraction: 1,

                      onPageChanged: (index, reason) {
                        return setState(() => activeIndex = index);
                      },
                    )),
                SizedBox(
                  height: 0.5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSmoothIndicator(
                        activeIndex: activeIndex,
                        count: widget.images.length,
                        effect: WormEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            dotColor: AppColors.greyColor,
                            activeDotColor: Theme.of(context).primaryColor))
                  ],
                )
              ],
            ),
          )
        : CachedNetworkImage(
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: AppColors.greyColor.withOpacity(0.5),
              highlightColor: AppColors.greyColor,
              child: Container(
                height: 40.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.w),
                  color: Colors.grey,
                ),
              ),
            ),
            imageBuilder: (context, imageProvider) => InkWell(
              onTap: () {
                GeneralRoute.navigatorPushWithContext(
                  type: PageTransitionType.fade,
                  context,
                  ViewImagesWidget(
                    image: widget.image,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.w),
                    // image: DecorationImage(
                    //     image: imageProvider, fit: BoxFit.cover),
                    border: Border.all(color: AppColors.greyColor)),
                child: Image(
                  height: 40.h,
                  width: double.infinity,
                  image: imageProvider,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            fadeInDuration: const Duration(milliseconds: 4),
            fadeOutDuration: const Duration(milliseconds: 4),
            imageUrl: widget.image!,
            errorWidget: (context, url, error) => Container(
              padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.all(color: AppColors.greyColor),
                borderRadius: BorderRadius.circular(4.w),
              ),
              child: Image(
                height: 40.h,
                width: double.infinity,
                image: const AssetImage(AppAssets.fallImage),
                color: Theme.of(context).scaffoldBackgroundColor,
                fit: BoxFit.contain,
              ),
            ),
            // fit: BoxFit.cover,
          );
  }
}
