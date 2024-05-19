import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? textData;
  final int? maxLines;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? padding;
  final TextOverflow? textOverflow;
  final TextDirection? textDirection;
  final TextStyle? textStyle;

  const CustomText(
      {super.key,
      this.textData,
      this.textDirection,
      this.maxLines,
      this.textAlign,
      this.textOverflow,
      this.padding,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    Widget text = Text(textData ?? "Empty text",
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: textOverflow,
        textDirection: textDirection,
        style: textStyle);
    return Padding(padding: padding ?? EdgeInsets.zero, child: text);
  }
}
