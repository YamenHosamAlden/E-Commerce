import 'package:ecommerce/Util/functions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SelectColorWidget extends StatefulWidget {
  final List<String> colors;
  final Function(String) selectedColor;
  const SelectColorWidget(
      {super.key, required this.colors, required this.selectedColor});

  @override
  State<SelectColorWidget> createState() => _SelectColorWidgetState();
}

class _SelectColorWidgetState extends State<SelectColorWidget> {
  late List<bool> selectColor = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.colors.length; i++) {
      if (i == 0) {
        selectColor.add(true);
      } else {
        selectColor.add(false);
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
          selectColor.length,
          (index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.w),
              child: InkWell(
                onTap: () {
                  setState(() {
                    for (int indexBtn = 0;
                        indexBtn < selectColor.length;
                        indexBtn++) {
                      if (indexBtn == index) {
                        selectColor[indexBtn] = true;

                        widget.selectedColor(widget.colors[indexBtn]);
                      } else {
                        selectColor[indexBtn] = false;
                      }
                    }
                  });
                },
                child: Container(
                    height: 5.h,
                    width: 10.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(colorParseInt(widget.colors[index])),
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 3,
                          color: selectColor[index]
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).focusColor),
                    ),
                    child: Icon(
                      Icons.check,
                      color: selectColor[index]
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                    )),
              ),
            );
          },
        )),
      ),
    );
  }
}
