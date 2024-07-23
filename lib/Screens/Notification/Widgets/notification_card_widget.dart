import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Data/Models/notification_model.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NotificationCardWidget extends StatelessWidget {
  final Message notification;
  const NotificationCardWidget({required this.notification, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomText(
                    textData: notification.title,
                    textAlign: TextAlign.start,
                    textStyle: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                if (!notification.isSeen!)
                  Image(
                    height: 3.h,
                    width: 6.w,
                    color: Theme.of(context).primaryColor,
                    image: const AssetImage(AppAssets.errorIcon),
                  )
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Row(
                children: [
                  Expanded(
                    child: CustomText(
                      textData: notification.body,
                      textAlign: TextAlign.start,
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Row(
                children: [
                  Expanded(
                    child: CustomText(
                      textData: notification.timeCreated,
                      textAlign: TextAlign.start,
                      textStyle: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  Expanded(
                    child: CustomText(
                      textData: notification.dateCreated,
                      textAlign: TextAlign.end,
                      textStyle: Theme.of(context).textTheme.bodySmall,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
