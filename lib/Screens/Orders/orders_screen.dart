import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, title: "My Orders".tr(context)),
      body: DefaultTabController(
          length: 5,
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
                  Tab(text: "Accepted Orders".tr(context)),
                  Tab(text: "Pending Orders".tr(context)),
                  Tab(text: "Delivering Orders".tr(context)),
                  Tab(text: "Rejected Orders".tr(context)),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Container(),
                    Container(),
                    Container(),
                    Container(),
                    Container()
                  ],
                ),
              )
            ],
          )),
    );
  }
}
