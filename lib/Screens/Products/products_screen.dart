import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/products_bloc/products_bloc.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
// import 'package:ecommerce/Screens/Home/Widgets/search_widget.dart';
import 'package:ecommerce/Screens/Products/Widgets/product_card_widget.dart';
import 'package:ecommerce/Screens/Products/Widgets/select_filter_bottom_sheet.dart';
import 'package:ecommerce/Widgets/app_bar_widget.dart';
import 'package:ecommerce/Widgets/custom_drop_down_widget.dart';
import 'package:ecommerce/Widgets/empty_widget.dart';
import 'package:ecommerce/Widgets/error_message_widget.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ProductsScreen extends StatefulWidget {
  final String slug;
  final String categoryName;
  final bool withFilter;
  const ProductsScreen(
      {this.withFilter = true,
      required this.categoryName,
      required this.slug,
      super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductsBloc productsBloc = ProductsBloc();
  List<String> sortByList = [];
  String? sortBy;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sortBy = "Recomended".tr(context);
    sortByList = [
      "Recomended".tr(context),
      "New arrival".tr(context),
      "Highest price".tr(context),
      "Lowest price".tr(context)
    ];
    return BlocProvider(
      create: (context) =>
          productsBloc..add(GetProductListEvent(slug: widget.slug)),
      child: Scaffold(
        appBar: appBarWidget(context, title: widget.categoryName),
        body: Column(
          children: [
            // SearchWidget(
            //   searchFun: (searchName) {
            //     productsBloc.add(
            //         SearchResultEvent(result: searchName, slug: widget.slug));
            //   },
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              child: Row(
                children: [
                  Expanded(
                    child: CustomDropDownWidget(
                      hintText: "Sort by".tr(context),
                      dropdownValue: sortBy,
                      values: sortByList,
                      onChanged: (newSort) {
                        sortBy = newSort;
                        productsBloc.add(GetProductListEvent(
                            slug: widget.slug, sortBy: sortBy));
                      },
                    ),
                  ),
                  if (widget.withFilter) ...[
                    InkWell(
                      onTap: () {
                        selectFilterBottomSheet(
                          context,
                          slug: widget.slug,
                          filterSelect:
                              (sizeIds, brandIds, minPrice, maxPrice) {
                            productsBloc.add(GetProductFiltaredListEvent(
                                slug: widget.slug,
                                brandIds: brandIds,
                                sizeIds: sizeIds,
                                minPrice: minPrice,
                                maxPrice: maxPrice));

                    
                          },
                        );
                      },
                      borderRadius: BorderRadius.circular(3.w),
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 1.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 1.2.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor,
                              borderRadius: BorderRadius.circular(3.w),
                              border: Border.all(
                                  color: Theme.of(context).primaryColor)),
                          child: Image(
                              height: 3.h,
                              width: 6.w,
                              color: Theme.of(context).primaryColor,
                              image: const AssetImage(AppAssets.filterIcon))),
                    ),
                  ],
                  SizedBox(
                    width: 2.w,
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  if (state is GetProductListErrorState) {
                    return ErrorMessageWidget(
                        message: state.message,
                        onPressed: () {
                          productsBloc
                              .add(GetProductListEvent(slug: widget.slug));
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
          ],
        ),
      ),
    );
  }
}
