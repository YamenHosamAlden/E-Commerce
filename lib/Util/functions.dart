import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

// Future<void> launch(Uri url) async {
//   await canLaunchUrl(url)
//       ? await launchUrl(url, mode: LaunchMode.externalApplication)
//       : Fluttertoast.showToast(
//           msg: "Could Not Launch",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 3,
//           backgroundColor: AppColors.redColor,
//           textColor: AppColors.primaryColor,
//           fontSize: 16.0);
// }

SnackBar errorSnackBar(BuildContext context, {required String message}) {
  SnackBar snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.up,

    // margin: EdgeInsets.only(
    //     bottom: MediaQuery.of(context).size.height - 25.h,
    //     right: 2.w,
    //     left: 2.w),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w)),
    backgroundColor: AppColors.redColor,
    duration: const Duration(seconds: 4),
    content: Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      child: Row(
        children: [
          Image(
              height: 2.h,
              width: 4.w,
              color: Theme.of(context).textTheme.labelMedium!.color,
              image: const AssetImage(AppAssets.errorIcon)),
          SizedBox(
            width: 2.w,
          ),
          Expanded(
              child: CustomText(
                  textData: message,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                  textStyle: TextStyle(
                      color: Theme.of(context).textTheme.labelMedium!.color))),
        ],
      ),
    ),
  );
  return snackBar;
}

SnackBar successSnackBar(BuildContext context, {required String message}) {
  SnackBar snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.up,
    // margin: EdgeInsets.only(
    //     bottom: MediaQuery.of(context).size.height - 25.h,
    //     right: 2.w,
    //     left: 2.w),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w)),
    backgroundColor: AppColors.greanColor,
    duration: const Duration(seconds: 4),
    content: Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      child: CustomText(
          textData: message,
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
          textStyle:
              TextStyle(color: Theme.of(context).textTheme.labelMedium!.color)),
    ),
  );
  return snackBar;
}

int colorParseInt(String colorString) {
  int colorInt = int.parse(colorString.replaceFirst('#', '0xFF'));
  return colorInt;
}

List<bool> convertTrueToFalse(List<bool> inputList) {
  return inputList.map((item) => item == true ? false : item).toList();
}


String addCommasToNumber(int number) {
  String numStr = number.toString();
  // التعبير العادي لإيجاد أماكن إضافة الفواصل
  RegExp regExp = RegExp(r'\B(?=(\d{3})+(?!\d))');
  // استبدال الأماكن المناسبة بالفاصلة
  String result = numStr.replaceAllMapped(regExp, (Match match) => ',');
  return result;
}