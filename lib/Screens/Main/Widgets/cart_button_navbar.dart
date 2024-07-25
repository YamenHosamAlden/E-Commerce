import 'package:ecommerce/Bloc/cart_bloc/cart_bloc.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';

BottomNavigationBarItem bottomNavigationBarCart(BuildContext context,
    {required int currentIndex,
    String? imageIcon,
    required int index,
    required String navBarName}) {
  return BottomNavigationBarItem(
    icon: BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is GetMyCartErrorState) {
          return IconButton(
              onPressed: () {
                BlocProvider.of<CartBloc>(context).add(GetCartListEvent());
              },
              icon: Icon(
                Icons.replay_outlined,
                color: Theme.of(context).iconTheme.color,
              ));
        }
        return Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              padding: EdgeInsets.symmetric(vertical: 1.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentIndex == index
                    ? Theme.of(context).iconTheme.color
                    : Colors.transparent,
              ),
              child: Image(
                image: AssetImage(imageIcon!),
                height: 3.h,
                width: 6.w,
                color: currentIndex == index
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).iconTheme.color,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
              margin: EdgeInsets.symmetric(horizontal: 6.w),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.redColor),
              child: CustomText(
                textData:
                    "${BlocProvider.of<CartBloc>(context).cartModel?.products?.length ?? 0}",
                textStyle: TextStyle(
                    color: AppColors.lightWhiteColor,
                    fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        );
      },
    ),
    label: navBarName,
  );
}
