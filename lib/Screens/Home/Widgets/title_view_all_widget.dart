import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class TitleWithViewAllWidget extends StatelessWidget {
  final String title;
  final Function onTap;
  const TitleWithViewAllWidget(
      {super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            textData: title,
           textStyle: Theme.of(context).textTheme.headlineMedium,
          ),
          InkWell(
            onTap: () {
              onTap();
            },
            child: CustomText(
              textData: "View All".tr(context),
          
            
            
            ),
          )
        ],
      ),
    );
  }
}
