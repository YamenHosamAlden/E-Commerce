import 'package:ecommerce/Screens/Orders/Widgets/order_design_widget.dart';
import 'package:flutter/material.dart';

class ListOfOrdersWidget extends StatelessWidget {
  const ListOfOrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return OrderDesignWidget(orderState: "");
              });
  }
}