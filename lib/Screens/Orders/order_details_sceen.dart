import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/orders_bloc/orders_bloc.dart';
import 'package:ecommerce/Screens/Orders/Widgets/delivery_type_widget.dart';
import 'package:ecommerce/Screens/Orders/Widgets/order_status_widget.dart';
import 'package:ecommerce/Screens/Orders/Widgets/product_order_widget.dart';
import 'package:ecommerce/Widgets/app_bar_widget.dart';
import 'package:ecommerce/Widgets/custom_smart_refrecher_header_widget.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:ecommerce/Widgets/error_message_widget.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

class OrderDetailsSceen extends StatelessWidget {
  final int orderId;
  OrderDetailsSceen({required this.orderId, super.key});
  final OrdersBloc ordersBloc = OrdersBloc();
  final RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ordersBloc..add(GetOrderEvent(orderId: orderId)),
      child: Scaffold(
        appBar: appBarWidget(context, title: "Order details".tr(context)),
        body: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            if (state is GetOrderLoadingState || state is OrdersInitial) {
              return const LoadingWidget();
            }
            if (state is GetOrderErrorState) {
              return ErrorMessageWidget(
                  message: state.message,
                  onPressed: () {
                    ordersBloc.add(GetAllOrdersEvent());
                  });
            }
            return SmartRefresher(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                controller: refreshController,
                onRefresh: () {
                  ordersBloc.add(GetOrderEvent(orderId: orderId));
                  refreshController.refreshCompleted();
                },
                header: const CustomSmartRefrecherHeaderWidget(),
                child: ListView(
                  children: [
                    Container(
                      color: Theme.of(context).cardColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 1.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    textData: ordersBloc
                                        .orderDetailsModel!.dateCreated,
                                    textStyle:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  CustomText(
                                    textData: ordersBloc
                                        .orderDetailsModel!.timeCreated,
                                    textStyle:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            orderState(context,
                                status:
                                    ordersBloc.orderDetailsModel!.orderStatus!)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      color: Theme.of(context).cardColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                               Expanded(
                              child: CustomText(
                                textData: "Delivery".tr(context),
                                textStyle:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                            deliveryType(context,
                                type:
                                    ordersBloc.orderDetailsModel!.pickUpMethod!)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      color: Theme.of(context).cardColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomText(
                                textData: "Products".tr(context),
                               textStyle:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 1.h,
                    // ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: ordersBloc.orderDetailsModel!.order!.length,
                      itemBuilder: (context, index) {
                        return ProductOrderWidget(
                            order: ordersBloc.orderDetailsModel!.order![index]);
                      },
                    ),
                  ],
                ));
          },
        ),
      ),
    );
  }
}
