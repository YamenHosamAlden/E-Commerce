import 'package:ecommerce/Screens/Home/Widgets/app_bar_home_screen.dart';
import 'package:ecommerce/Screens/Home/Widgets/drawer_widget.dart';
import 'package:ecommerce/Screens/Home/Widgets/home_categories_list_widget.dart';
import 'package:ecommerce/Screens/Home/Widgets/list_of_new_products.dart';
import 'package:ecommerce/Screens/Home/Widgets/offers_slider_widget.dart';
import 'package:ecommerce/Screens/Home/Widgets/search_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      //  backgroundColor:   Theme.of(context).colorScheme.background,
      appBar: appBarHomeScreenWidget(context, scaffoldKey: scaffoldKey,title: "ECommerce", ),
      drawer: const DrawerWidget(),
      body: ListView(
        children:const  [
          SearchWidget(
         
          ),
           HomeCaregoriesListWidget(),
           OffersSliderWidget(),
           ListOfNewProducts()
        ],
      ),
    );
  }
}
