import 'package:bloc/bloc.dart';
import 'package:ecommerce/Data/Models/cart_model.dart';
import 'package:ecommerce/Data/Repository/cart_repository.dart';
import 'package:ecommerce/Services/Helper/api_result.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartModel? cartModel;
  CouponModel? couponModel;

  int totalQuantity = 0;
  int totalDiscount = 0;

  CartBloc() : super(CartInitial()) {
    CartRepository cartRepository = CartRepository();

    on<AddToCartEvent>((event, emit) async {
      emit(AddToCartLoadingState());

      ApiResult apiResult = await cartRepository.addToCart(
          productId: event.productId, productDetailId: event.productDetailId);

      if (apiResult.response != null && apiResult.response!.statusCode == 201) {
        emit(AddToCartSuccessfulState());
      } else {
        emit(AddToCartErrorState(message: apiResult.error));
      }
    });

    on<RemoveFormCartListEvent>((event, emit) async {
      emit(RemoveFormCartLoadingState());

      ApiResult apiResult = await cartRepository.removeFromCart(
          all: event.all, productDetailId: event.productDetailId);

      if (apiResult.response!.statusCode == 200) {
        if (event.all != null) {
          emit(RemoveFromCartListSuccessfulState(
              message: "All products have been removed from cart"));

          add(GetCartListEvent());
        } else {
          emit(RemoveFromCartListSuccessfulState(
              message: "The product has been removed from cart"));
        }
      } else {
        emit(RemoveFromCartListErrorState(message: apiResult.error));
      }
    });

    on<GetCartListEvent>((event, emit) async {
      emit(GetMyCartLoadingState());

      ApiResult apiResult = await cartRepository.getMyCartList();

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        cartModel = CartModel.fromJson(apiResult.response!.data);

        emit(GetMyCartSuccessfulState());
      } else {
        emit(GetMyCartErrorState(message: apiResult.error));
      }
    });

    on<ChangeQtyEvent>((event, emit) async {
      emit(ChangeQtyLoadingState());

      ApiResult apiResult = await cartRepository.changeQty(
          productDetailId: event.productDetailId, qty: event.qty);

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        cartModel!.totalPrice = apiResult.response!.data['message'];
        emit(ChangeQtySuccessfulState());
      } else {
        emit(ChangeQtyErrorState(message: apiResult.error));
      }
    });

    on<AddCouponEvent>((event, emit) async {
      totalQuantity = 0;
      emit(AddCouponLoadingState());

      ApiResult apiResult = await cartRepository.addCoupon(
        couponCode: event.couponCode,
      );

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        couponModel = CouponModel.fromJson(apiResult.response!.data);
        for (Products element in cartModel!.products!) {
          if (couponModel!.coupon!.supplierId ==
              element.product!.productDetail!.supplierId) {
            totalQuantity += element.quantity!;
          }
        }
        totalDiscount =
            totalQuantity * couponModel!.coupon!.discountValue!;

        emit(AddCouponSuccessfulState());
      } else {
        emit(AddCouponErrorState(message: apiResult.error));
      }
    });
  }
}
