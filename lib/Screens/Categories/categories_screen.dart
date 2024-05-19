import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Screens/Categories/Widgets/categories_list_widget.dart';
import 'package:ecommerce/Screens/Categories/Widgets/sub_categories_list_widget.dart';
import 'package:ecommerce/Widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: appBarWidget(context, title: "Categories".tr(context), buttonBack: false),
      body: const Row(
        children: [
          Expanded(child: CategoriesListWidget()),
          Expanded(flex: 2, child: SubCategoriesListWidget())
        ],
      ),
    );
  }
}
