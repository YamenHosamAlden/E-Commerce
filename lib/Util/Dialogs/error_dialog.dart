import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

errorDialog(BuildContext context,
    {required String message, required Function onPressed}) {
  AlertDialog alertDialog = AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.w),
        side:
             BorderSide(width: 2, color: Theme.of(context).primaryColor)),
    actionsPadding: EdgeInsets.only(bottom: 3.h, right: 4.w, left: 4.w),
    actionsAlignment: MainAxisAlignment.center,
    actions: [
      SizedBox(
        width: double.infinity,
        child: CustomButton(
            onPressed: () {
              onPressed();
            },
            buttonText: "Try again".tr(context)),
      )
    ],
    content: SizedBox(
      // height: 30.h,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
  showDialog(
    barrierDismissible: false,
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return alertDialog;
    },
  );
}
