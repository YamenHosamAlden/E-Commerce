import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Data/Models/product_model.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:ecommerce/Widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:sizer/sizer.dart';

class ReviewsWidget extends StatelessWidget {
  final List<ReviewSet> reviewSet;
  const ReviewsWidget({super.key, required this.reviewSet});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Row(
              children: [
                CustomText(
                  textData: "Reviews".tr(context),
                  textStyle: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        reviewSet.isNotEmpty?  ListView.builder(
            itemCount: reviewSet.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Card(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: CustomText(
                                textData: reviewSet[index].customer,
                                textStyle:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: StarRating(
                                rating: reviewSet[index].rating!.toDouble(),
                                size: 4.w,
                                color: Theme.of(context).primaryColor,
                                allowHalfRating: true,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomText(
                                textData: reviewSet[index].comment,
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ):EmptyWidget(message: "There is no reviews".tr(context)),
        ],
      ),
    );
  }
}
