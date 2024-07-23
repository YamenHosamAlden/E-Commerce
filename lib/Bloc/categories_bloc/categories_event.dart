part of 'categories_bloc.dart';

@immutable
sealed class CategoriesEvent {}

class GetAllCategoriesEvent extends CategoriesEvent {}

class GetSubCategoryEvent extends CategoriesEvent {
  final String slug;
 

  GetSubCategoryEvent({required this.slug});
}
