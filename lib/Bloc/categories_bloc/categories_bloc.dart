import 'package:bloc/bloc.dart';
import 'package:ecommerce/Data/Models/categories_model.dart';
import 'package:ecommerce/Data/Repository/categories_repository.dart';
import 'package:ecommerce/Services/Helper/api_result.dart';
import 'package:meta/meta.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesRepository categoriesRepository = CategoriesRepository();
  List<Categories>? categories;
  List<Categories>? subCategory;
  String? slug;
  String? categoryName;

  CategoriesBloc() : super(CategoriesInitial()) {
    on<GetAllCategoriesEvent>((event, emit) async {
      emit(GetAllCategoriesLoadingState());

      ApiResult apiResult = await categoriesRepository.getAllCategories();

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        List<dynamic> res = apiResult.response!.data;

        categories =
            res.map((category) => Categories.fromJson(category)).toList();

        categoryName = categories!.first.name!;
        slug = categories!.first.slug!;

        emit(GetAllCategoriesSuccessfulState());
        add(GetSubCategoryEvent(
          slug: categories!.first.slug!,
        ));
      } else {
        emit(GetAllCategoriesErrorState(message: apiResult.error));
      }
    });

    on<GetSubCategoryEvent>((event, emit) async {
      emit(GetSubCategoryLoadingState());

      ApiResult apiResult =
          await categoriesRepository.getSubCategory(slug: event.slug);

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        List<dynamic> res = apiResult.response!.data;

        subCategory =
            res.map((subCategory) => Categories.fromJson(subCategory)).toList();

        emit(GetSubCategorySuccessfulState());
      } else {
        emit(GetSubCategoryErrorState(message: apiResult.error));
      }
    });
  }
}
