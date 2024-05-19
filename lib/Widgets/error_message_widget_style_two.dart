import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ErrorMessageWidgetStyleTwo extends StatelessWidget {
  final Function onPressed;
  final String message;

  const ErrorMessageWidgetStyleTwo(
      {super.key, required this.message, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onPressed();
      },
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                message,
                textAlign: TextAlign.center,
              )),
            ],
          ),
          Icon(
            Icons.restart_alt_rounded,
            color: Theme.of(context).primaryColor,
            size: 20.sp,
          )
        ],
      ),
    );
  }
}
