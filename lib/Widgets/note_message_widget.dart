// import 'package:ecommerce/Core/Constants/app_assets.dart';
// import 'package:ecommerce/Core/Constants/app_colors.dart';
// import 'package:ecommerce/Widgets/custom_text.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

// class NoteMessageWidget extends StatelessWidget {
//   final String message;
//   const NoteMessageWidget({required this.message, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image(
//               image: const AssetImage(AppAssets.football1Image),
//               height: 25.h,
//               width: 45.w,
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: CustomText(
//                   padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
//                   textData: message,
//                   textAlign: TextAlign.center,
//                   textColor: Theme.of(context).primaryColor,
//                   fontSize: 15.sp,
//                   fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
