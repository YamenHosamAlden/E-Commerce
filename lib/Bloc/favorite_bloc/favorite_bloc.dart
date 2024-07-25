import 'package:bloc/bloc.dart';
import 'package:ecommerce/Data/Models/product_model.dart';
import 'package:ecommerce/Data/Repository/product_repository.dart';
import 'package:ecommerce/Services/Helper/api_result.dart';
import 'package:meta/meta.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  ProductRepository productRepository = ProductRepository();
  bool? inWishList;

  FavorateProductListModel? favorateProductListModel;
  FavoriteBloc() : super(FavoriteInitial()) {

       on<FavoriteToCartEvent>((event, emit) async {
      emit(LoadingState());

      ApiResult apiResult = await productRepository.favoriteToCart(
         );

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
      

        emit(FavoriteToCartSuccessfulState());
      } else {
        emit(FavoriteToCartErrorState(message: apiResult.error));
      }
    });
    on<AddToFavoriteListEvent>((event, emit) async {
      emit(LoadingState());

      ApiResult apiResult = await productRepository.addToFavorite(
          productId: event.productId, productDetailId: event.productDetailId);

      if (apiResult.response != null && apiResult.response!.statusCode == 201) {
        inWishList = true;

        emit(AddToFavoriteListSuccessfulState());
      } else {
        emit(AddToFavoriteListErrorState(message: apiResult.error));
      }
    });

    on<RemoveFormFavoriteListEvent>((event, emit) async {
      emit(LoadingState());

      ApiResult apiResult = await productRepository.removeFromFavorite(
        all: event.all,
          productId: event.productId, productDetailId: event.productDetailId);

      if (apiResult.response!.statusCode == 200) {
        if (event.all != null) {
          emit(RemoveFromFavoriteListSuccessfulState(
              message: "All products have been removed from favorites"));
        } else {
          inWishList = false;
          emit(RemoveFromFavoriteListSuccessfulState(
              message: "The product has been removed from favorites"));
        }
      } else {
        emit(RemoveFromFavoriteListErrorState(message: apiResult.error));
      }
    });

    on<GetMyFavoriteListEvent>((event, emit) async {
      emit(GetMyFavoriteListLoadingState());

      ApiResult apiResult = await productRepository.getMyFavoriteList();

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        favorateProductListModel =
            FavorateProductListModel.fromJson(apiResult.response!.data);
        emit(GetMyFavoriteListSuccessfulState());
      } else {
        emit(GetMyFavoriteListErrorState(message: apiResult.error));
      }
    });
  }
}
