import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ListHorizontalShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  const ListHorizontalShimmerWidget({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Shimmer.fromColors(
            baseColor: AppColors.greyColor.withOpacity(0.5),
            highlightColor: AppColors.greyLightColor,
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(4.w)),
            ),
          )),
    );
  }
}
