// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}

class GetProductDetailsEvent extends ProductsEvent {
  final String slug;

  GetProductDetailsEvent({required this.slug});
}

class SwitchProductDetailsEvent extends ProductsEvent {
  final String size;
  final String color;

  SwitchProductDetailsEvent({required this.size, required this.color});
}

class GetProductListEvent extends ProductsEvent {
  final String slug;
  final String? sortBy;
  GetProductListEvent({required this.slug, this.sortBy});
}

class GetProductListByTypeEvent extends ProductsEvent {
  final String productsType;

  GetProductListByTypeEvent({required this.productsType});
}

class SearchResultEvent extends ProductsEvent {
  final String result;
  final String slug;
  SearchResultEvent({required this.result, required this.slug});
}

class GetProductsPromotionEvent extends ProductsEvent {
  final int promotionId;

  GetProductsPromotionEvent({required this.promotionId});
}

class GetPromotionsEvent extends ProductsEvent {}

class GetProductFiltaredListEvent extends ProductsEvent {
  final String slug;
  final List<int>? sizeIds;
  final List<int>? brandIds;
  final String? minPrice;
  final String? maxPrice;

  GetProductFiltaredListEvent({
    required this.slug,
    this.sizeIds,
    this.brandIds,
    this.minPrice,
    this.maxPrice,
  });
}
