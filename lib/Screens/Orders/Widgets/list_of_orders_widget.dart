import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Data/Models/orders_model.dart';
import 'package:ecommerce/Screens/Orders/Widgets/order_design_widget.dart';
import 'package:ecommerce/Widgets/empty_widget.dart';
import 'package:flutter/material.dart';

class ListOfOrdersWidget extends StatelessWidget {
  final List<Orders> orders;
  const ListOfOrdersWidget({required this.orders, super.key});

  @override
  Widget build(BuildContext context) {
   
    return orders.isNotEmpty
        ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return OrderDesignWidget(
                order: orders[index],
              );
            })
        : EmptyWidget(message: "There is no orders".tr(context));
  }
}
