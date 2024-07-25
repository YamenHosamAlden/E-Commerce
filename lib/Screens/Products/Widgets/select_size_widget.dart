import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SelectSizeWidget extends StatefulWidget {
  final List<String> sizes;

  final Function(String) selectedSize;

  const SelectSizeWidget(
      {super.key, required this.sizes, required this.selectedSize});

  @override
  State<SelectSizeWidget> createState() => _SelectSizeWidgetState();
}

class _SelectSizeWidgetState extends State<SelectSizeWidget> {
  List<bool> selectSize = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.sizes.length; i++) {
      if (i == 0) {
        selectSize.add(true);
      } else {
        selectSize.add(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.h,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: List.generate(
          selectSize.length,
          (index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.w),
              child: InkWell(
                onTap: () {
                  setState(() {
                    for (int indexBtn = 0;
                        indexBtn < selectSize.length;
                        indexBtn++) {
                      if (indexBtn == index) {
                        selectSize[indexBtn] = true;
                        widget.selectedSize(widget. sizes[indexBtn]);
                      } else {
                        selectSize[indexBtn] = false;
                      }
                    }
                  });
                },
                child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.w),
                      border: Border.all(
                          width: 2,
                          color: selectSize[index]
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).hintColor),
                    ),
                    child: CustomText(
                      textData: widget.sizes[index],
                      textStyle: TextStyle(
                          fontSize: 14.sp,
                          color: selectSize[index]
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).hintColor),
                    )),
              ),
            );
          },
        )),
      ),
    );
  }
}
