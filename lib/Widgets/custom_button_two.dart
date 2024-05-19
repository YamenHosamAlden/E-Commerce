import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButtonTwo extends StatelessWidget {
  final String buttonText;
  final Function onTap;
  final Color buttonColor;
  final IconData buttonIcon;
  const CustomButtonTwo(
      {super.key,
      required this.buttonText,
      required this.onTap,
      required this.buttonIcon,
      required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: buttonColor,
        onTap: () {
          onTap();
        },
        borderRadius: BorderRadius.circular(3.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: buttonColor),
              borderRadius: BorderRadius.circular(3.w)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
           
              Text(
                buttonText,
                style: TextStyle(color: buttonColor, fontSize: 8.sp),
              ),
                 Icon(
               buttonIcon,
               size: 10.sp,
                color: buttonColor,
              ),
            ],
          ),
        ));
  }
}
