import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final String icon;
  final TextStyle? textStyle;
  final Function onTap;
  const DrawerItem(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.title,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ImageIcon(AssetImage(icon),
          size: 8.w, color: Theme.of(context).primaryColor),
      title: CustomText(
        textData: title,
        textStyle: textStyle,
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
