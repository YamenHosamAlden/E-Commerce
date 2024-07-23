import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ListOfShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final int itemCount;
  final double radius;
  const ListOfShimmerWidget({
    super.key,
    required this.height,
    this.itemCount = 10,
    required this.radius,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
        child: Shimmer.fromColors(
          baseColor: AppColors.greyColor.withOpacity(0.5),
          highlightColor: AppColors.greyLightColor,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(radius)),
          ),
        ),
      ),
    );
  }
}
