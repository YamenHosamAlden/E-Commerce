import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class DropDownQuantityWidget extends StatefulWidget {
  final List<int> values;
  final int? dropdownValue;

  final Function(int?) onChanged;

  const DropDownQuantityWidget(
      {required this.values,
      required this.onChanged,
      super.key,
      this.dropdownValue});

  @override
  State<DropDownQuantityWidget> createState() =>
      _DropDownQuantityWidgetsState();
}

class _DropDownQuantityWidgetsState extends State<DropDownQuantityWidget> {
  int? dropdownValue;

  @override
  void initState() {
    super.initState();

    if (widget.dropdownValue != null) {
      dropdownValue = widget.dropdownValue;
    }
  }


  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<int>(
   isDense: true,
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
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
        focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
        errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
        border: Theme.of(context).inputDecorationTheme.border,
        contentPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
        errorStyle: const TextStyle(height: 1.5),
        alignLabelWithHint: true,
      ),
        iconStyleData:
          IconStyleData(iconEnabledColor: Theme.of(context).primaryColor),
      value: dropdownValue,
      style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 12.sp
      ),
      items: widget.values.map((value) {
        return DropdownMenuItem(
            alignment: Alignment.center,
            value: value,
            child: CustomText(
              textData: "$value",
         
            ));
      }).toList(),
      onChanged: widget.onChanged,
    );
  }
}
