import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/cart_bloc/cart_bloc.dart';
import 'package:ecommerce/Screens/Cart/Widgets/complete_order_widget.dart';
import 'package:ecommerce/Screens/Cart/Widgets/product_shop_widget.dart';
import 'package:ecommerce/Util/Dialogs/confirm_dialog.dart';
import 'package:ecommerce/Util/functions.dart';
import 'package:ecommerce/Widgets/app_bar_widget.dart';
import 'package:ecommerce/Widgets/custom_button.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:ecommerce/Widgets/custom_text_falid.dart';
import 'package:ecommerce/Widgets/empty_widget.dart';
import 'package:ecommerce/Widgets/error_message_widget.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:sizer/sizer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartBloc cartBloc;
  @override
  void initState() {
    super.initState();
    cartBloc = BlocProvider.of<CartBloc>(context);
    cartBloc.add(GetCartListEvent());
  }

  TextEditingController couponCodeController = TextEditingController();

  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBarWidget(context, title: "Cart".tr(context), buttonBack: false),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is RemoveFromCartListErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(errorSnackBar(context, message: state.message));
          }

          if (state is RemoveFromCartListSuccessfulState) {
            ScaffoldMessenger.of(context).showSnackBar(
                errorSnackBar(context, message: state.message.tr(context)));
            cartBloc.add(GetCartListEvent());
          }
        },
        builder: (context, state) {
          if (state is GetMyCartErrorState) {
            return ErrorMessageWidget(
                message: state.message,
                onPressed: () {
                  cartBloc.add(GetCartListEvent());
                });
          }

          if (state is GetMyCartLoadingState || state is CartInitial) {
            return const LoadingWidget();
          }
          return SmartRefresher(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            controller: refreshController,
            onRefresh: () {
              cartBloc.add(GetCartListEvent());
              refreshController.refreshCompleted();
            },
            child: cartBloc.cartModel!.products!.isNotEmpty
                ? Stack(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.5.h),
                            child: Row(
                              children: [
                                Expanded(
                                    child: CustomTextField(
                                        controller: couponCodeController,
                                        hintText: "Add your coupon".tr(context),
                                        textInputType: TextInputType.text)),
                                SizedBox(
                                  width: 0.5.w,
                                ),
                                Column(
                                  children: [
                                    CustomButton(
                                        onPressed: () {
                                          cartBloc.add(AddCouponEvent(
                                              couponCode:
                                                  couponCodeController.text));
                                        },
                                        buttonText: "Apply".tr(context)),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    showConfirmDialog(context,
                                        title:
                                            "Are you sure you have remove all the products in the cart?"
                                                .tr(context), onPressed: () {
                                      cartBloc
                                          .add(RemoveFormCartListEvent(all: 1));
                                    });
                                  },
                                  child: CustomText(
                                    textData: "Remove all".tr(context),
                                    textStyle: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .fontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: cartBloc.cartModel!.products!.length,
                              itemBuilder: (context, index) {
                                return ProductShopWidget(
                                  index: index,
                                  products:
                                      cartBloc.cartModel!.products![index],
                                );
                              },
                            ),
                          ),
                          CompleteOrderWidget(
                              userMaxUse:
                                  cartBloc.couponModel?.coupon?.userMaxUse,
                              totalDiscount: cartBloc.totalDiscount,
                              totalPrice: cartBloc.cartModel!.totalPrice!)
                        ],
                      ),
                      if (state is RemoveFormCartLoadingState ||
                          state is ChangeQtyLoadingState ||
                          state is AddCouponLoadingState)
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.3),
                          alignment: Alignment.center,
                          child: const LoadingWidget(),
                        )
                    ],
                  )
                : EmptyWidget(message: "Cart is empty".tr(context)),
          );
        },
      ),
    );
  }
}
