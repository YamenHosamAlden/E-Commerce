import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ViewSmallImagesWidget extends StatelessWidget {
  final List<String> images;
  const ViewSmallImagesWidget({required this.images, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: images
          .map((image) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.5.w),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Center(
                    child: Shimmer.fromColors(
                      baseColor: AppColors.greyColor.withOpacity(0.5),
                      highlightColor: AppColors.greyLightColor,
                      child: Container(
                        height: 6.h,
                        width: 12.w,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4.w),
                        ),
                      ),
                    ),
                  ),
                  imageBuilder: (context, imageProvider) =>
                      Image(height: 6.h, width: 12.w, image: imageProvider),
                  fadeInDuration: const Duration(milliseconds: 4),
                  fadeOutDuration: const Duration(milliseconds: 4),
                  imageUrl: image,
                  errorWidget: (context, url, error) => Container(
                    height: 6.h,
                    width: 12.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.greyLightColor,
                      borderRadius: BorderRadius.circular(4.w),
                      border: Border.all(width: 1, color: AppColors.greyColor),
                    ),
                    child: Image(
                      image: const AssetImage(AppAssets.fallImage),
                      color: Theme.of(context).primaryColor,
                      fit: BoxFit.contain,
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              ))
          .toList(),
    );
  }
}
