part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}
class AddToCartSuccessfulState extends CartState {}


class AddToCartErrorState extends CartState {
  final String message;
  AddToCartErrorState({required this.message});
}

class AddToCartLoadingState extends CartState {}
class RemoveFormCartLoadingState extends CartState {}

class RemoveFromCartListSuccessfulState extends CartState {
    final String message;
  RemoveFromCartListSuccessfulState({required this.message});
}


class RemoveFromCartListErrorState extends CartState {
  final String message;
  RemoveFromCartListErrorState({required this.message});
}


class GetMyCartLoadingState extends CartState {}

class GetMyCartSuccessfulState extends CartState {}


class GetMyCartErrorState extends CartState {
  final String message;
  GetMyCartErrorState({required this.message});
}


class ChangeQtyLoadingState extends CartState {}

class ChangeQtySuccessfulState extends CartState {}


class ChangeQtyErrorState extends CartState {
  final String message;
  ChangeQtyErrorState({required this.message});
}

class AddCouponLoadingState extends CartState {}

class AddCouponSuccessfulState extends CartState {}


class AddCouponErrorState extends CartState {
  final String message;
  AddCouponErrorState({required this.message});
}