part of 'products_bloc.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

class GetProductDetailsLoadingState extends ProductsState {}

class GetProductDetailsSuccessfulState extends ProductsState {}

class GetProductDetailsErrorState extends ProductsState {
  final String message;
  GetProductDetailsErrorState({required this.message});
}

class GetProductListLoadingState extends ProductsState {}

class GetProductListSuccessfulState extends ProductsState {}

class GetProductListErrorState extends ProductsState {
  final String message;
  GetProductListErrorState({required this.message});
}
