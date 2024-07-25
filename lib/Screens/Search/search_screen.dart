import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/search_bloc/search_bloc.dart';
import 'package:ecommerce/Screens/Products/Widgets/product_card_widget.dart';
import 'package:ecommerce/Screens/Search/Widgets/search_bar_widget.dart';
import 'package:ecommerce/Widgets/app_bar_widget.dart';
import 'package:ecommerce/Widgets/empty_widget.dart';
import 'package:ecommerce/Widgets/error_message_widget.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final SearchBloc searchBloc = SearchBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => searchBloc,
      child: Scaffold(
        appBar: appBarWidget(context, title: "Search".tr(context)),
        body: Column(
          children: [
            SearchBarWidget(searchBloc: searchBloc),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            //   margin: EdgeInsets.only(bottom: 1.h),
            //   decoration: BoxDecoration(
            //       color: Theme.of(context).primaryColor,
            //       borderRadius: BorderRadius.only(
            //           bottomRight: Radius.circular(5.w),
            //           bottomLeft: Radius.circular(5.w))),
            //   child: CustomTextField(
            //       controller: searchController,
            //       hintText: "Search for anything you want".tr(context),
            //       prefixIcon: InkWell(
            //         onTap: () {
            //           searchBloc.add(
            //               SearchResultEvent(result: searchController.text));
            //         },
            //         child: Padding(
            //           padding:
            //               EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            //           child: Image(
            //             image: const AssetImage(AppAssets.searchIcon),
            //             color: Theme.of(context).primaryColor,
            //             width: 5.w,
            //             height: 2.h,
            //             fit: BoxFit.fill,
            //           ),
            //         ),
            //       ),
            //       textInputType: TextInputType.text),
            // ),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchResultErrorState) {
                    return ErrorMessageWidget(
                        message: state.message,
                        onPressed: () {
                          searchBloc.add(
                              SearchResultEvent(result: ""));
                        });
                  }
                  if (state is SearchResultLoadingState) {
                    return const LoadingWidget();
                  }
                  if (searchBloc.productList != null) {
                    return searchBloc.productList!.products!.isNotEmpty
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 5,
                              childAspectRatio: 0.61,
                            ),
                            itemCount: searchBloc.productList!.products!.length,
                            itemBuilder: (context, index) {
                              return ProductCardWidget(
                                product:
                                    searchBloc.productList!.products![index],
                              );
                            },
                          )
                        : EmptyWidget(
                            message: "There is no products".tr(context));
                  }
                  return EmptyWidget(message: "Search result".tr(context));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
