import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

ThemeData dark = ThemeData(
  useMaterial3: true,
  primaryColor: AppColors.darkPrimaryColor,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkScaffoldBackgroundColor,
  hintColor: AppColors.darkGrayColor,
  cardColor: AppColors.darkCardColor,
  inputDecorationTheme: InputDecorationTheme(

       enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.darkGrayColor, width: 1),
          borderRadius: BorderRadius.circular(2.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:const  BorderSide(color: AppColors.darkPrimaryColor, width: 1),
          borderRadius: BorderRadius.circular(2.w),
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.w),
            borderSide: const BorderSide(color: AppColors.redColor)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.w),
            borderSide:const BorderSide(color:AppColors.darkGrayColor, width: 1)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.w),
            borderSide:const  BorderSide(color: AppColors.darkWhiteColor, width: 1)),
            fillColor: AppColors.darkWhiteColor

  ),
  iconTheme: const IconThemeData(
    color: AppColors.darkWhiteColor,
  ),
  textTheme: TextTheme(
    displayMedium: TextStyle(
      color: AppColors.darkWhiteColor,
      fontSize: 10.sp,
    ),
    headlineLarge: TextStyle(
        color: AppColors.darkWhiteColor,
        fontWeight: FontWeight.bold,
        fontSize: 20.sp),
    headlineMedium: TextStyle(
        color: AppColors.darkWhiteColor,
        fontWeight: FontWeight.bold,
        fontSize: 14.sp),
          headlineSmall: TextStyle(
        color: AppColors.darkWhiteColor,
        fontWeight: FontWeight.bold,
        fontSize: 12.sp),
             bodyLarge: TextStyle(
      color: AppColors.darkWhiteColor,
      fontSize: 18.sp,
      fontWeight: FontWeight.bold
    ),
    bodyMedium: TextStyle(
      color: AppColors.darkWhiteColor,
      fontSize: 12.sp,
    ),
    bodySmall: TextStyle(color: AppColors.darkWhiteColor, fontSize: 8.sp),
    labelMedium: TextStyle(
        color: AppColors.darkWhiteColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold),
    labelSmall: TextStyle(
        color: AppColors.darkPrimaryColor,
        fontSize: 12.sp,
        fontWeight: FontWeight.bold),
  ),
  colorScheme: const ColorScheme.dark(
    primary: AppColors.darkSchemeColor,
    secondary: AppColors.darkWhiteColor,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
