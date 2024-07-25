import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/orders_bloc/orders_bloc.dart';
import 'package:ecommerce/Screens/Orders/Widgets/list_of_orders_widget.dart';
import 'package:ecommerce/Widgets/app_bar_widget.dart';
import 'package:ecommerce/Widgets/custom_smart_refrecher_header_widget.dart';
import 'package:ecommerce/Widgets/error_message_widget.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});
  final OrdersBloc ordersBloc = OrdersBloc();
  final RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ordersBloc..add(GetAllOrdersEvent()),
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: appBarWidget(context, title: "My Orders".tr(context)),
          body: BlocBuilder<OrdersBloc, OrdersState>(
            builder: (context, state) {
              if (state is GetAllOrdersLoadingState || state is OrdersInitial) {
                return const LoadingWidget();
              }
              if (state is GetAllOrdersErrorState) {
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
                  ordersBloc.add(GetAllOrdersEvent());
                  refreshController.refreshCompleted();
                },
                header: const CustomSmartRefrecherHeaderWidget(),
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: Theme.of(context).primaryColor,
                      labelColor: Theme.of(context).primaryColor,
                      dividerColor: Colors.transparent,
                      tabAlignment: TabAlignment.start,
                      labelStyle: Theme.of(context).textTheme.headlineMedium,
                      isScrollable: true,
                      tabs: [
                        Tab(
                          text: "All".tr(context),
                        ),
                        Tab(text: "Pending Orders".tr(context)),
                        Tab(text: "Delivering Orders".tr(context)),
                        Tab(text: "Delivered Orders".tr(context)),
                        Tab(text: "Cancelled Orders".tr(context)),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          ListOfOrdersWidget(
                            orders: ordersBloc.ordersListModel!.orders!,
                          ),
                          ListOfOrdersWidget(
                            orders: ordersBloc
                                .ordersListModel!.ordersPreprocessing!,
                          ),
                          ListOfOrdersWidget(
                            orders: ordersBloc.ordersListModel!.ordersPickedUp!,
                          ),
                          ListOfOrdersWidget(
                            orders: ordersBloc.ordersListModel!.ordersDeliverd!,
                          ),
                          ListOfOrdersWidget(
                            orders:
                                ordersBloc.ordersListModel!.ordersCancelled!,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
