import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/cart_bloc/cart_bloc.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Util/functions.dart';
import 'package:ecommerce/Widgets/custom_button.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class AddToCartButtonWidget extends StatelessWidget {
  final int? productId;
  final int? productDeatilId;
  final bool detailsScreen;
  AddToCartButtonWidget(
      {this.productDeatilId,
      this.productId,
      this.detailsScreen = false,
      super.key});
  final CartBloc cartBloc = CartBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context2) => cartBloc,
      child: BlocConsumer<CartBloc, CartState>(
        listener: (context2, state) {
          if (state is AddToCartErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(errorSnackBar(context, message: state.message));
          }
          if (state is AddToCartSuccessfulState) {
            ScaffoldMessenger.of(context).showSnackBar(successSnackBar(context,
                message: "The product has been added to the cart".tr(context)));
            BlocProvider.of<CartBloc>(context).add(GetCartListEvent());
          }
        },
        builder: (context, state) {
          if (detailsScreen) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: state is AddToCartLoadingState
                  ? SizedBox(
                      height: 6.h, width: 12.w, child: const LoadingWidget())
                  : SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                          onPressed: () {
                            cartBloc.add(AddToCartEvent(
                                productId: productId,
                                productDetailId: productDeatilId));
                          },
                          buttonText: "Add To Cart".tr(context)),
                    ),
            );
          } else {
            return Container(
              height: 4.h,
              width: 9.w,
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).iconTheme.color),
              child: state is AddToCartLoadingState
                  ? SizedBox(
                      height: 0.5.h, width: 0.5.w, child: const LoadingWidget())
                  : IconButton(
                      onPressed: () {
                        cartBloc.add(AddToCartEvent(
                            productId: productId,
                            productDetailId: productDeatilId));
                      },
                      icon: Image(
                        image: const AssetImage(AppAssets.cartIcon),
                        color: Theme.of(context).primaryColor,
                        height: 2.h,
                        width: 4.w,
                      )),
            );
          }
        },
      ),
    );
  }
}
