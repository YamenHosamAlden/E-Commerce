// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class AddToCartEvent extends CartEvent {
  final int? productId;
  final int? productDetailId;

  AddToCartEvent({
    this.productId,
    this.productDetailId,
  });
}

class RemoveFormCartListEvent extends CartEvent {
  final int? productDetailId;

  final int? all;
  RemoveFormCartListEvent({
    this.all,
    this.productDetailId,
  });
}

class GetCartListEvent extends CartEvent {}

class ChangeQtyEvent extends CartEvent {
  final int productDetailId;
  final int qty;

  ChangeQtyEvent({required this.productDetailId, required this.qty});
}

class AddCouponEvent extends CartEvent {
  final String couponCode;

  AddCouponEvent({
    required this.couponCode,
  });
}
