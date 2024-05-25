import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class TextInfoWidget extends StatelessWidget {
  final String text;
  final String info;
  const TextInfoWidget({required this.text, required this.info, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          textData: "$info : ",
          textStyle: Theme.of(context).textTheme.headlineMedium,
        ),
        CustomText(
          textAlign: TextAlign.start,
          textData: text,
        textStyle: 
          TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
