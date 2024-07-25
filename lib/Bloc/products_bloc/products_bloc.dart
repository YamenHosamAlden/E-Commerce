import 'package:bloc/bloc.dart';
import 'package:ecommerce/Data/Models/product_model.dart';
import 'package:ecommerce/Data/Models/promotion_model.dart';
import 'package:ecommerce/Data/Repository/product_repository.dart';
import 'package:ecommerce/Services/Helper/api_result.dart';
import 'package:meta/meta.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductRepository productRepository = ProductRepository();
  ProductModel? productModel;
  ProductDetails? productDetails;
  PromotionModel? promotionModel;
  ProductList? productList;

  String? color;
  String? size;

  ProductDetails getProductDetails(
      {required List<ProductDetails> data, String? color, String? size}) {
    for (ProductDetails productDetails in data) {
      if (productDetails.color == color && productDetails.size == size) {
        return productDetails;
      }
    }
    return data.first;
  }

  ProductsBloc() : super(ProductsInitial()) {
    on<GetProductDetailsEvent>((event, emit) async {
      emit(GetProductDetailsLoadingState());

      ApiResult apiResult =
          await productRepository.getProductDetails(slug: event.slug);

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        productModel = ProductModel.fromJson(apiResult.response!.data);

        if (productModel!.product!.colors.isNotEmpty) {
          color = productModel!.product!.colors.first;
        }
        if (productModel!.product!.sizes.isNotEmpty) {
          size = productModel!.product!.sizes.first;
        }

        productDetails = getProductDetails(
            data: productModel!.product!.productDetail!,
            color: color,
            size: size);

        emit(GetProductDetailsSuccessfulState());
      } else {
        emit(GetProductDetailsErrorState(message: apiResult.error));
      }
    });

    on<GetProductsPromotionEvent>((event, emit) async {
      emit(GetProductListLoadingState());

      ApiResult apiResult = await productRepository.getProductsPromotion(
          promotionId: event.promotionId);

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        productList = ProductList.fromJson(apiResult.response!.data);

        emit(GetProductListSuccessfulState());
      } else {
        emit(GetProductListErrorState(message: apiResult.error));
      }
    });

    on<GetPromotionsEvent>((event, emit) async {
      emit(GetProductListLoadingState());

      ApiResult apiResult = await productRepository.getPromotions();

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        promotionModel = PromotionModel.fromJson(apiResult.response!.data);
        emit(GetProductListSuccessfulState());
      } else {
        emit(GetProductListErrorState(message: apiResult.error));
      }
    });

    on<SwitchProductDetailsEvent>((event, emit) async {
      color = event.color;
      size = event.size;

      productDetails = getProductDetails(
          data: productModel!.product!.productDetail!,
          color: color!,
          size: size!);

      emit(GetProductDetailsSuccessfulState());
    });

    on<GetProductListEvent>((event, emit) async {
      emit(GetProductListLoadingState());

      ApiResult apiResult = await productRepository.getProductListByCategory(
          slug: event.slug, sortBy: event.sortBy);

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        productList = ProductList.fromJson(apiResult.response!.data);

        emit(GetProductListSuccessfulState());
      } else {
        emit(GetProductListErrorState(message: apiResult.error));
      }
    });

    on<GetProductFiltaredListEvent>((event, emit) async {
      emit(GetProductListLoadingState());

      ApiResult apiResult =
          await productRepository.getFiltardProductListByCategory(
              slug: event.slug,
              brandIds: event.brandIds,
              sizeIds: event.sizeIds,
              minPrice: event.minPrice,
              maxPrice: event.maxPrice);

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        productList = ProductList.fromJson(apiResult.response!.data);

        emit(GetProductListSuccessfulState());
      } else {
        emit(GetProductListErrorState(message: apiResult.error));
      }
    });

    on<SearchResultEvent>((event, emit) async {
      emit(GetProductListLoadingState());

      ApiResult apiResult = await productRepository.searchResult(
          result: event.result, slug: event.slug);

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        productList = ProductList.fromJson(apiResult.response!.data);

        emit(GetProductListSuccessfulState());
      } else {
        emit(GetProductListErrorState(message: apiResult.error));
      }
    });

    on<GetProductListByTypeEvent>((event, emit) async {
      emit(GetProductListLoadingState());

      ApiResult apiResult = await productRepository.getProductListByType(
          productsType: event.productsType);

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        productList = ProductList.fromJson(apiResult.response!.data);

        emit(GetProductListSuccessfulState());
      } else {
        emit(GetProductListErrorState(message: apiResult.error));
      }
    });
  }
}
