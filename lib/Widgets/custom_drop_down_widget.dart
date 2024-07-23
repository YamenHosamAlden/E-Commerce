import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:ecommerce/Widgets/custom_text_falid.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class CustomDropDownWidget extends StatefulWidget {
  final bool isValidator;
  final String? validatorMessage;
  final bool isSearch;
  final String? hintSearch;
  final String? hintText;

  final Color borderColor;
  final List<String> values;
  final String? dropdownValue;

  final Function(String?) onChanged;

  const CustomDropDownWidget(
      {this.validatorMessage,
      required this.values,
      this.isSearch = false,
      this.borderColor = Colors.transparent,
      this.hintText,
      this.isValidator = false,
      this.hintSearch,
      required this.onChanged,
      super.key,
      this.dropdownValue});

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetsState();
}

class _CustomDropDownWidgetsState extends State<CustomDropDownWidget> {
  String? dropdownValue;

  @override
  void initState() {
    super.initState();

    if (widget.dropdownValue != null) {
      dropdownValue = widget.dropdownValue;
    }
  }

  TextEditingController searchController = TextEditingController();

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
          searchController.clear();
        }
      },
      dropdownSearchData: widget.isSearch
          ? DropdownSearchData(
              searchController: searchController,
              searchInnerWidgetHeight: 5.h,
              searchMatchFn: (item, searchValue) {
                return item.value!.toString().contains(searchValue);
              },
              searchInnerWidget: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                child: CustomTextField(
                  textInputType: TextInputType.name,
                  hintText: widget.hintSearch,
                  controller: searchController,
                ),
              ))
          : null,
      dropdownStyleData: DropdownStyleData(
        maxHeight: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.w),
          color: Theme.of(context).cardColor,
        ),
        offset: const Offset(0, 0),
        scrollbarTheme: ScrollbarThemeData(
          radius: Radius.circular(5.w),
          thumbColor: WidgetStatePropertyAll(Theme.of(context).primaryColor),
          thickness: WidgetStateProperty.all(2.w),
          thumbVisibility: WidgetStateProperty.all(true),
        ),
      ),
      isExpanded: true,
      hint: Row(
        children: [
          Expanded(
            child: Text(
              widget.hintText ?? "",
              style: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      iconStyleData:
          IconStyleData(iconEnabledColor: Theme.of(context).primaryColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
        focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
        errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
        border: Theme.of(context).inputDecorationTheme.border,
        contentPadding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.h),
        errorStyle: const TextStyle(height: 1.5),
        alignLabelWithHint: true,
      ),
      value: dropdownValue,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 12.sp,
      ),
      items: widget.values.map((value) {
        return DropdownMenuItem(
            value: value,
            child: CustomText(
              textData: value,
              //  textStyle:     Theme.of(context).textTheme.bodyMedium!,
            ));
      }).toList(),
      onChanged: widget.onChanged,
    );
  }
}
