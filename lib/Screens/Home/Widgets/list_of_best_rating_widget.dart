import 'package:ecommerce/Data/Models/product_model.dart';
import 'package:ecommerce/Screens/Products/products_by_type_screen.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Screens/Home/Widgets/title_view_all_widget.dart';
import 'package:ecommerce/Screens/Products/Widgets/product_card_widget.dart';

class ListOfBestRatingWidget extends StatelessWidget {
  final List<Product> bestRating;
  const ListOfBestRatingWidget({
    super.key,
    required this.bestRating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 2.h,
        ),
        TitleWithViewAllWidget(title: "Best rating".tr(context), onTap: () {
             GeneralRoute.navigatorPushWithContext(
                  context,
                 const ProductByTypeScreen(
                      title:  "Best rating", productsType: "highest_rating"));
        }),
        // SizedBox(
        //   height: 0.5.h,
        // ),

        SizedBox(
         
          height: 36.h,
          width: double.infinity,
          child: ListView.builder(
            itemCount: bestRating.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) => ProductCardWidget(
              product: bestRating[index],
            ),
          ),
        )
        // GridView.builder(
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     mainAxisSpacing: 10,
        //     crossAxisSpacing: 5,
        //     childAspectRatio: 0.61,
        //   ),

        //   itemCount: newProducts.length,
        //   physics: const NeverScrollableScrollPhysics(),
        //   shrinkWrap: true,
        //   itemBuilder: (context, index) {
        //     return  ProductCardWidget(
        //       newProducts: newProducts[index],
        //     );
        //   },
        // ),
      ],
    );
  }
}
