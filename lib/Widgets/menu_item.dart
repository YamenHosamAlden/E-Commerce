import 'dart:core';

import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class MenuItemm extends StatefulWidget {
  final String title;
  final String image;

  final Function() onPressed;

  const MenuItemm({
    super.key,
    required this.title,
    required this.onPressed,
    required this.image,
  });

  @override
  State<MenuItemm> createState() => _MenuItemmState();
}

class _MenuItemmState extends State<MenuItemm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: MaterialButton(
        onPressed: widget.onPressed,
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                    bottom: BorderSide(
                        color: Theme.of(context)
                            .inputDecorationTheme
                            .border!
                            .borderSide
                            .color))),
            child: Column(children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            color: Theme.of(context).primaryColor,
                            widget.image,
                            height: 3.h,
                            width: 6.w,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          CustomText(
                            textData: widget.title,
                            textStyle: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ),
                    ],
                  )),
            ])),
      ),
    );
  }
}
