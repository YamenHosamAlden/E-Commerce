import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

ThemeData light = ThemeData(
  useMaterial3: true,
  primaryColor: AppColors.lightPrimaryColor,
  scaffoldBackgroundColor: AppColors.lightScaffoldBackgroundColor,
  hintColor: AppColors.darkGrayColor,
  brightness: Brightness.light,
  cardColor: AppColors.lightCardColor,
  inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.lightGrayColor, width: 1),
        borderRadius: BorderRadius.circular(2.w),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: AppColors.lightPrimaryColor, width: 1),
        borderRadius: BorderRadius.circular(2.w),
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.w),
          borderSide: const BorderSide(color: AppColors.redColor)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.w),
          borderSide: const BorderSide(color: AppColors.lightGrayColor, width: 1)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.w),
          borderSide:
              const BorderSide(color: AppColors.lightWhiteColor, width: 1)),
      fillColor: AppColors.lightWhiteColor),
  iconTheme: const IconThemeData(
    color: AppColors.lightGrayColor,
  ),
  textTheme: TextTheme(
    displayMedium: TextStyle(
      color: AppColors.lightWhiteColor,
      fontSize: 10.sp,
    ),
    headlineLarge: TextStyle(
        color: AppColors.lightWhiteColor,
        fontWeight: FontWeight.bold,
        fontSize: 20.sp),
    headlineMedium: TextStyle(
        color: AppColors.lightBlackColor,
        fontWeight: FontWeight.bold,
        fontSize: 14.sp),

            headlineSmall: TextStyle(
        color: AppColors.lightBlackColor,
        fontWeight: FontWeight.bold,
        fontSize: 12.sp),


          bodyLarge: TextStyle(
      color: AppColors.lightBlackColor,
      fontSize: 18.sp,
      fontWeight: FontWeight.bold
    ),
    bodyMedium: TextStyle(
      color: AppColors.lightBlackColor,
      fontSize: 12.sp,
    ),
    bodySmall: TextStyle(color: AppColors.lightBlackColor, fontSize: 8.sp),
    labelMedium: TextStyle(
        color: AppColors.lightWhiteColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold),
    labelSmall: TextStyle(
        color: AppColors.lightPrimaryColor,
        fontSize: 12.sp,
        fontWeight: FontWeight.bold),
  ),
  colorScheme: const ColorScheme.light(
    primary: AppColors.lightSchemeColor,
    secondary: AppColors.lightBlackColor,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
