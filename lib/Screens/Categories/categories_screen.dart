import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/categories_bloc/categories_bloc.dart';
import 'package:ecommerce/Screens/Categories/Widgets/categories_list_widget.dart';
import 'package:ecommerce/Screens/Categories/Widgets/sub_categories_list_widget.dart';
import 'package:ecommerce/Widgets/app_bar_widget.dart';
import 'package:ecommerce/Widgets/error_message_widget.dart';
import 'package:ecommerce/Widgets/list_of_shimmer_loaading_widget.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late CategoriesBloc categoriesBloc;

  @override
  void initState() {
    super.initState();
    categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    categoriesBloc.add(GetAllCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context,
          title: "Categories".tr(context), buttonBack: false),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state is GetAllCategoriesLoadingState ||
              state is CategoriesInitial) {
            return Row(
              children: [
                Expanded(
                  child: ListOfShimmerWidget(
                    height: 4.h,
                    itemCount: 15,
                    radius: 1.w,
                  ),
                ),
                const Expanded(flex: 2, child: LoadingWidget())
              ],
            );
          }

          if (state is GetAllCategoriesErrorState) {
            return ErrorMessageWidget(
                message: state.message,
                onPressed: () {
                  categoriesBloc.add(GetAllCategoriesEvent());
                });
          }
          return Row(
            children: [
              Expanded(
                  child: CategoriesListWidget(
                categories: categoriesBloc.categories!,
                selectSlug: (newSlug, newCategory) {
                  categoriesBloc.categoryName = newCategory;
                  categoriesBloc.slug = newSlug;
                  categoriesBloc.add(GetSubCategoryEvent(slug: newSlug));
                },
              )),
              const Expanded(flex: 2, child: SubCategoriesListWidget())
            ],
          );
        },
      ),
    );
  }
}
