import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:ecommerce/Widgets/custom_text_falid.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class CustomDropDown extends StatefulWidget {
  final bool isValidator;

  final String? validatorMessage;
  final bool isSearch;
  final String? hintSearch;
  final String? hintText;
  final Color? fillColor;
  final Color borderColor;
  final List<String> values;
  final String? dropdownValue;
  final TextEditingController controller;

  final Function(String?) onChanged;

  const CustomDropDown(
      {this.validatorMessage,
      required this.controller,
      this.dropdownValue,
      required this.values,
      this.isSearch = false,
      this.borderColor = Colors.transparent,
      this.hintText,
      this.fillColor,
      this.isValidator = false,
      this.hintSearch,
      required this.onChanged,
      super.key});

  @override
  State<CustomDropDown> createState() => _CustomDropDownsState();
}

class _CustomDropDownsState extends State<CustomDropDown> {
  TextEditingController textEditingController = TextEditingController();

  String? dropdownValue;
  @override
  void initState() {
    super.initState();
    if (widget.dropdownValue != null) {
      dropdownValue = widget.dropdownValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      validator: widget.isValidator
          ? (input) {
              if (input == null) {
                return widget.validatorMessage!;
              }
              return null;
            }
          : null,
      onMenuStateChange: (isOpen) {
        if (!isOpen) {
          textEditingController.clear();
        }
      },
      dropdownSearchData: widget.isSearch
          ? DropdownSearchData(
              searchController: textEditingController,
              searchInnerWidgetHeight: 5.h,
              searchMatchFn: (item, searchValue) {
                return item.value!.toString().contains(searchValue);
              },
              searchInnerWidget: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                child: CustomTextField(
                  textInputType: TextInputType.name,
                  hintText: widget.hintSearch,
                  controller: textEditingController,
                ),
              ))
          : null,
      dropdownStyleData: DropdownStyleData(
        maxHeight: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.w),
          color: Theme.of(context).primaryColor,
        ),
        offset: const Offset(0, 0),
        scrollbarTheme: ScrollbarThemeData(
          radius: Radius.circular(5.w),
          thumbColor:
               MaterialStatePropertyAll(Theme.of(context).primaryColor),
          thickness: MaterialStateProperty.all(2.w),
          thumbVisibility: MaterialStateProperty.all(true),
        ),
      ),
      isExpanded: true,
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: widget.fillColor != null,
        fillColor: widget.fillColor,
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColors.greyLightColor, width: 1),
          borderRadius: BorderRadius.circular(2.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColors.greyLightColor, width: 1),
          borderRadius: BorderRadius.circular(2.w),
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.w),
            borderSide: const BorderSide(color: Colors.red)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.w),
            borderSide:
                const BorderSide(color: AppColors.greyLightColor, width: 1)),
        contentPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
        counterText: '',
        hintStyle: TextStyle(color: AppColors.greyLightColor, fontSize: 12.sp),
        errorStyle: const TextStyle(height: 1.5),
        alignLabelWithHint: true,
      ),
      value: widget.dropdownValue,
      style: TextStyle(
        fontSize: 13.sp,
        color: Theme.of(context).primaryColor,
      ),
      items: widget.values.map((value) {
        return DropdownMenuItem(
            value: value,
            child: CustomText(
              textData: value,
            ));
      }).toList(),
      onChanged: (newValue) {
        widget.onChanged(newValue);
      },
    );
  }
}
