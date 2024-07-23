import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/products_bloc/products_bloc.dart';
import 'package:ecommerce/Screens/Products/Widgets/product_card_widget.dart';
import 'package:ecommerce/Widgets/app_bar_widget.dart';
import 'package:ecommerce/Widgets/empty_widget.dart';
import 'package:ecommerce/Widgets/error_message_widget.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPromotionScreen extends StatefulWidget {
  final int promotionId;
  final String title;

  const ProductsPromotionScreen(
      {required this.title, required this.promotionId, super.key});

  @override
  State<ProductsPromotionScreen> createState() => _ProductsPromotionScreenState();
}

class _ProductsPromotionScreenState extends State<ProductsPromotionScreen> {
  final ProductsBloc productsBloc = ProductsBloc();
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    return BlocProvider(
      create: (context) => productsBloc
        ..add(GetProductsPromotionEvent(promotionId: widget.promotionId)),
      child: Scaffold(
        appBar: appBarWidget(context, title: widget.title),
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is GetProductListErrorState) {
              return ErrorMessageWidget(
                  message: state.message,
                  onPressed: () {
                    productsBloc.add(GetProductsPromotionEvent(
                        promotionId: widget.promotionId));
                  });
            }
                
            if (state is GetProductListLoadingState ||
                state is ProductsInitial) {
              return const LoadingWidget();
            }
            return productsBloc.productList!.products!.isNotEmpty
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.61,
                    ),
                    itemCount: productsBloc.productList!.products!.length,
                    itemBuilder: (context, index) {
                      return ProductCardWidget(
                        product:
                            productsBloc.productList!.products![index],
                      );
                    },
                  )
                : EmptyWidget(
                    message: "There is no products".tr(context));
          },
        ),
      ),
    );
  }
}
