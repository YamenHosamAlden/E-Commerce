import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class EmptyWidget extends StatelessWidget {
  final String message;
  const EmptyWidget({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.w),
                border: Border.all(
                    width: 1, color: Theme.of(context).primaryColor)),
            child: CustomText(
              textData: message,
            )),
      ],
    );
  }
}
