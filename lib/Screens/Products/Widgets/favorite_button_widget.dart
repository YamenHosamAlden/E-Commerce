import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/favorite_bloc/favorite_bloc.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Util/functions.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class FavoriteButtonWidget extends StatefulWidget {
  final bool inWishList;
  final int? productDetailId;
  final int? productId;

  const FavoriteButtonWidget({
    required this.inWishList,
    this.productDetailId,
    this.productId,
    super.key,
  });

  @override
  State<FavoriteButtonWidget> createState() => _FavoriteButtonWidgetState();
}

class _FavoriteButtonWidgetState extends State<FavoriteButtonWidget> {
  @override
  void initState() {
    favoriteBloc.inWishList = widget.inWishList;
    super.initState();
  }

  final FavoriteBloc favoriteBloc = FavoriteBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => favoriteBloc,
      child: Container(
        height: 4.h,
        width: 8.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.w),
            color: Theme.of(context).iconTheme.color!.withOpacity(0.5)),
        child: BlocConsumer<FavoriteBloc, FavoriteState>(
          listener: (context, state) {
            if (state is AddToFavoriteListErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
                context,
                message: state.message,
              ));
            }

            if (state is AddToFavoriteListSuccessfulState) {
              ScaffoldMessenger.of(context).showSnackBar(successSnackBar(
                context,
                message: "Add to favorite successful".tr(context),
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
            }
          },
          builder: (context, state) {
            return state is! LoadingState
                ? IconButton(
                    onPressed: () {
                      if (favoriteBloc.inWishList!) {
                        favoriteBloc.add(RemoveFormFavoriteListEvent(
                          productId: widget.productId,

                            productDetailId: widget.productDetailId,));
                      } else {
                        favoriteBloc.add(AddToFavoriteListEvent(
                          productId: widget.productId,
                            productDetailId: widget.productDetailId));
                      }
                    },
                    icon: Image(
                      image: AssetImage(favoriteBloc.inWishList!
                          ? AppAssets.heartIcon
                          : AppAssets.heartOutIcon),
                      color: AppColors.redColor,
                      height: 2.h,
                      width: 4.w,
                    ))
                : SizedBox(
                    height: 0.5.h, width: 0.5.w, child: const LoadingWidget());
          },
        ),
      ),
    );
  }
}
