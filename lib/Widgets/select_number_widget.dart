import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:sizer/sizer.dart';

class SelectNumberWidget extends StatefulWidget {
  final Function(int) getSelectedNumber;
  final String title;
  final int minValue;
  final int maxValue;
  final int initValue;
  const SelectNumberWidget(
      {required this.maxValue,
      required this.title,
      required this.minValue,
      required this.getSelectedNumber,
      required this.initValue,
      super.key});

  @override
  State<SelectNumberWidget> createState() => _SelectNumberWidgetState();
}

class _SelectNumberWidgetState extends State<SelectNumberWidget> {
  late int selectedValue;
  @override
  void initState() {
    super.initState();
    selectedValue = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.h,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.textFieldColor,
          border: Border.all(color: AppColors.greyLightColor),
          borderRadius: BorderRadius.circular(2.w)),
      child: Row(
        children: [
          Text(widget.title,
              style:  TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor)),
          Expanded(
            child: NumberPicker(
              // decoration: BoxDecoration(
              //     border: Border.all(color: Theme.of(context).primaryColor),
              //     borderRadius: BorderRadius.circular(2.w)),
              axis: Axis.horizontal,
              // itemHeight: 5.h,
              // itemWidth: 24.w,
              textStyle: TextStyle(
                color: AppColors.greyColor,
                fontSize: 10.sp,
              ),
              selectedTextStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
              value: selectedValue,
              minValue: widget.minValue,
              maxValue: widget.maxValue,
              onChanged: (value) {
                setState(() => selectedValue = value);
                widget.getSelectedNumber(value);
              },
            ),

            // ScrollDatePicker(
            //   indicator: Container(
            //     height: 10.h,
            //     decoration: BoxDecoration(
            //         // color: AppColors.lightgreyColor,
            //         borderRadius: BorderRadius.circular(5.w)),
            //   ),
            //   scrollViewOptions: DatePickerScrollViewOptions.all(
            //       ScrollViewDetailOptions(
            //           selectedTextStyle: const TextStyle(
            //               color: Theme.of(context).primaryColor,
            //               fontWeight: FontWeight.bold),
            //           textStyle: TextStyle(
            //               color: AppColors.greyColor.withOpacity(0.5)))),
            //   selectedDate: selectedDate,
            //   locale: const Locale('ar'),
            //   viewType: [DatePickerViewType.year],
            //   onDateTimeChanged: (DateTime value) {
            //     widget.getDate(value);
            //     setState(() {
            //       selectedDate = value;
            //     });
            //     // print("what is the selectedDate :$selectedDate");
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}
