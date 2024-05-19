import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

BottomNavigationBarItem bottomNavigationBarItem(BuildContext context,
    {required int currentIndex,
    String? imageIcon,
    IconData? iconData,
    required int index,
    required String navBarName}) {
  return BottomNavigationBarItem(
    icon: Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      padding: EdgeInsets.symmetric(vertical: 1.h),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentIndex == index
            ? Theme.of(context).iconTheme.color
            : Colors.transparent,
      ),
      child: iconData != null
          ? Icon(
              iconData,
              color: currentIndex == index
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).iconTheme.color,
              size: 8.w,
            )
          : ImageIcon(
              AssetImage(imageIcon!),
              size: 6.w,
              color: currentIndex == index
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).iconTheme.color,
            ),
    ),
    label: navBarName,
  );
}
