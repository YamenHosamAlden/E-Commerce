part of 'categories_bloc.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

class GetAllCategoriesLoadingState extends CategoriesState {}

class GetAllCategoriesSuccessfulState extends CategoriesState {}

class GetAllCategoriesErrorState extends CategoriesState {
  final String message;
  GetAllCategoriesErrorState({required this.message});
}

class GetSubCategoryLoadingState extends CategoriesState {}

class GetSubCategorySuccessfulState extends CategoriesState {}

class GetSubCategoryErrorState extends CategoriesState {
  final String message;
  GetSubCategoryErrorState({required this.message});
}
