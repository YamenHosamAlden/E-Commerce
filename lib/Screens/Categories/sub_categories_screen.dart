import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/categories_bloc/categories_bloc.dart';
import 'package:ecommerce/Screens/Categories/Widgets/card_category.dart';
import 'package:ecommerce/Widgets/app_bar_widget.dart';
import 'package:ecommerce/Widgets/empty_widget.dart';
import 'package:ecommerce/Widgets/error_message_widget.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCategoriesScreen extends StatelessWidget {
  final String categoryName;
  final String slug;
  SubCategoriesScreen(
      {super.key, required this.categoryName, required this.slug});
  final CategoriesBloc categoriesBloc = CategoriesBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => categoriesBloc
        ..add(GetSubCategoryEvent(slug: slug, )),
      child: Scaffold(
        appBar: appBarWidget(context, title: categoryName),
        body: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            if (state is GetSubCategoryErrorState) {
              return ErrorMessageWidget(
                message: state.message,
                onPressed: () {
                  categoriesBloc.add(GetAllCategoriesEvent());
                },
              );
            }
            if (state is GetSubCategoryLoadingState ||
                state is CategoriesInitial) {
              return const LoadingWidget();
            }
            return categoriesBloc.subCategory!.isNotEmpty
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: categoriesBloc.subCategory!.length,
                    itemBuilder: (context, index) {
                      return CardCategoryWidget(
                        categories: categoriesBloc.subCategory![index],
                      );
                    },
                  )
                : EmptyWidget(message: "There is no subcategory".tr(context));
          },
        ),
      ),
    );
  }
}
