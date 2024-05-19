import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Data/Models/categories_model.dart';
import 'package:ecommerce/Screens/Home/Widgets/title_view_all_widget.dart';
import 'package:ecommerce/Screens/Products/Widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ListOfNewProducts extends StatelessWidget {
  const ListOfNewProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 2.h,
        ),
        TitleWithViewAllWidget(title: "New products".tr(context), onTap: () {}),
        SizedBox(
          height: 2.h,
        ),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 5,
            childAspectRatio: 0.56,
          ),
          itemCount: listCategoriesModel.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return const ProductCardWidget();
          },
        ),
      ],
    );
  }
}
