import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/categories_bloc/categories_bloc.dart';
import 'package:ecommerce/Screens/Categories/Widgets/card_category.dart';
import 'package:ecommerce/Screens/Products/products_screen.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:ecommerce/Widgets/empty_widget.dart';
import 'package:ecommerce/Widgets/error_message_widget.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class SubCategoriesListWidget extends StatefulWidget {
  const SubCategoriesListWidget({super.key});

  @override
  State<SubCategoriesListWidget> createState() =>
      _SubCategoriesListWidgetState();
}

class _SubCategoriesListWidgetState extends State<SubCategoriesListWidget> {
  late CategoriesBloc categoriesBloc;

  @override
  void initState() {
    categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            return InkWell(
              onTap: () {
                GeneralRoute.navigatorPushWithContext(
                    context,
                    ProductsScreen(
                      slug: categoriesBloc.slug!,
                      categoryName: categoriesBloc.categoryName!,
                      withFilter: false,
                    ));
              },
              child: Container(
                // width: double.infinity,
                // margin: EdgeInsets.symmetric(horizontal: 2.w),
                padding: EdgeInsets.symmetric(vertical: 1.h),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5.w),
                        bottomRight: Radius.circular(5.w))),
                alignment: Alignment.center,
                child: CustomText(
                  textData: categoriesBloc.categoryName,
                  textAlign: TextAlign.center,
                  textStyle: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            );
          },
        ),
        Expanded(
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
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
              return categoriesBloc.subCategory != null &&
                      categoriesBloc.subCategory!.isNotEmpty
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: categoriesBloc.subCategory!.length,
                      itemBuilder: (context, index) {
                        return CardCategoryWidget(
                          titleMaxLine: 2,
                          categories: categoriesBloc.subCategory![index],
                        );
                      },
                    )
                  : EmptyWidget(message: "There is no subcategory".tr(context));
            },
          ),
        ),
      ],
    );
  }
}
