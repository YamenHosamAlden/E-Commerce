import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Data/Models/categories_model.dart';
import 'package:ecommerce/Screens/Categories/Widgets/card_category.dart';

import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeCaregoriesListWidget extends StatelessWidget {
  final List<Categories> categories;
const  HomeCaregoriesListWidget({required this.categories,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Row(
            children: [
              Expanded(
                child: CustomText(
                  textData: "Categories".tr(context),
                  textAlign: TextAlign.start,
                  textStyle: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CardCategoryWidget(
                titleMaxLine: 1,
                categories: categories[index],

              );
            },
          ),
        ),
      ],
    );
  }
}
