import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/favorite_bloc/favorite_bloc.dart';
import 'package:ecommerce/Screens/Products/Widgets/product_card_widget.dart';
import 'package:ecommerce/Util/Dialogs/confirm_dialog.dart';
import 'package:ecommerce/Util/functions.dart';
import 'package:ecommerce/Widgets/app_bar_widget.dart';
import 'package:ecommerce/Widgets/custom_button.dart';
import 'package:ecommerce/Widgets/custom_smart_refrecher_header_widget.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:ecommerce/Widgets/empty_widget.dart';
import 'package:ecommerce/Widgets/error_message_widget.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final FavoriteBloc favoriteBloc = FavoriteBloc();

  final RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => favoriteBloc..add(GetMyFavoriteListEvent()),
      child: Scaffold(
        appBar: appBarWidget(context, title: "Favorite".tr(context)),
        body: BlocConsumer<FavoriteBloc, FavoriteState>(
          listener: (context, state) {
            if (state is FavoriteToCartErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
                context,
                message: state.message,
              ));
            }
            if (state is FavoriteToCartSuccessfulState) {
              ScaffoldMessenger.of(context).showSnackBar(successSnackBar(
                context,
                message: "All products are in the cart".tr(context),
              ));
            }
            if (state is RemoveFromFavoriteListErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
                context,
                message: state.message,
              ));
            }
            if (state is RemoveFromFavoriteListSuccessfulState) {
              ScaffoldMessenger.of(context).showSnackBar(successSnackBar(
                context,
                message: state.message.tr(context),
              ));
              favoriteBloc.add(GetMyFavoriteListEvent());
            }
          },
          builder: (context, state) {
            if (state is GetMyFavoriteListLoadingState ||
                state is FavoriteInitial) {
              return const LoadingWidget();
            }
            if (state is GetMyFavoriteListErrorState) {
              return ErrorMessageWidget(
                  message: state.message,
                  onPressed: () {
                    favoriteBloc.add(GetMyFavoriteListEvent());
                  });
            }
            return Column(
              children: [
                if (favoriteBloc
                    .favorateProductListModel!.productModel!.isNotEmpty)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            showConfirmDialog(context,
                                title:
                                    "Are you sure you have remove all the products in the favorite?"
                                        .tr(context), onPressed: () {
                              favoriteBloc
                                  .add(RemoveFormFavoriteListEvent(all: 1));
                            });
                          },
                          child: CustomText(
                            textData: "Remove all",
                            textStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .fontSize,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                Expanded(
                  child: SmartRefresher(
                    controller: refreshController,
                    enablePullUp: false,
                    enablePullDown: true,
                    header: const CustomSmartRefrecherHeaderWidget(),
                    onRefresh: () {
                      favoriteBloc.add(GetMyFavoriteListEvent());

                      refreshController.refreshCompleted();
                    },
                    child: favoriteBloc
                            .favorateProductListModel!.productModel!.isNotEmpty
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 5,
                              childAspectRatio: 0.61,
                            ),
                            itemCount: favoriteBloc
                                .favorateProductListModel!.productModel!.length,
                            itemBuilder: (context, index) {
                              return ProductCardWidget(
                                favoriteScreen: true,
                                product: favoriteBloc.favorateProductListModel!
                                    .productModel![index].product,
                                productModel: favoriteBloc
                                    .favorateProductListModel!
                                    .productModel![index],
                              );
                            },
                          )
                        : EmptyWidget(
                            message: "There is no products in the favorite"
                                .tr(context)),
                  ),
                ),
                favoriteBloc.favorateProductListModel!.productModel!.isNotEmpty
                    ? state is LoadingState
                        ? const LoadingWidget()
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 3.w),
                            child: SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                  onPressed: () {
                                    favoriteBloc.add(FavoriteToCartEvent());
                                  },
                                  buttonText: "Products to cart".tr(context)),
                            ),
                          )
                    : const SizedBox()
              ],
            );
          },
        ),
      ),
    );
  }
}
