import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Screens/Cart/Widgets/product_shop_widget.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      floatingActionButton: FloatingActionButton.large(

       
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              textAlign: TextAlign.center,
              textData: "Send Order".tr(context),
              textStyle:  Theme.of(context).textTheme.bodyMedium
            ),
             Icon(Icons.send,color: Theme.of(context).textTheme.bodyMedium!.color,size: 5.w,)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ProductShopWidget();
        },
      ),
    );
  }
}
