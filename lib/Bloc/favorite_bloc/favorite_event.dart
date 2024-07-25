part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {}

class AddToFavoriteListEvent extends FavoriteEvent {
  final int? productId;
  final int? productDetailId;

  AddToFavoriteListEvent({
    this.productId,
    this.productDetailId,
  });
}

class RemoveFormFavoriteListEvent extends FavoriteEvent {
  final int? productDetailId;
  final int? productId;
  final int? all;
  RemoveFormFavoriteListEvent({ this.all,this.productDetailId, this.productId});
}

class GetMyFavoriteListEvent extends FavoriteEvent {}
class FavoriteToCartEvent extends FavoriteEvent {}
