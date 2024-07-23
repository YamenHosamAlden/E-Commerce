import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String buttonText;
  final FontWeight? fontWeight;
  final double fontSize;
  final Color? textColor;
  final double? buttonHight;
  final Color? buttonColor;

  const CustomButton(
      {required this.onPressed,
      required this.buttonText,
      this.buttonColor,
      this.buttonHight,
      this.fontWeight = FontWeight.bold,
      this.textColor,
      this.fontSize = 16,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: buttonColor ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5.w),
      ),
      child: MaterialButton(
          height: buttonHight,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.w)),
          // color: buttonColor,
          onPressed: () {
            onPressed();
          },
          child: CustomText(
            textData: buttonText,
            textAlign: TextAlign.center,
            textStyle: textColor != null
                ? TextStyle(
                    color: textColor,
                    fontSize: Theme.of(context).textTheme.labelMedium!.fontSize)
                : Theme.of(context).textTheme.labelMedium,
          )),
    );
  }
}
