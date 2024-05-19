import 'package:ecommerce/Data/Models/categories_model.dart';
import 'package:ecommerce/Screens/Categories/Widgets/card_category.dart';
import 'package:flutter/material.dart';

class SubCategoriesListWidget extends StatelessWidget {
  const SubCategoriesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
      ),
      itemCount: listCategoriesModel.length,
      itemBuilder: (context, index) {
        return CardCategoryWidget(
          categoriesModel: listCategoriesModel[index],
        );
      },
    );
  }
}
