part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

class AddToFavoriteListSuccessfulState extends FavoriteState {}


class AddToFavoriteListErrorState extends FavoriteState {
  final String message;
  AddToFavoriteListErrorState({required this.message});
}

class LoadingState extends FavoriteState {}

class RemoveFromFavoriteListSuccessfulState extends FavoriteState {
    final String message;
  RemoveFromFavoriteListSuccessfulState({required this.message});
}


class RemoveFromFavoriteListErrorState extends FavoriteState {
  final String message;
  RemoveFromFavoriteListErrorState({required this.message});
}


class GetMyFavoriteListLoadingState extends FavoriteState {}

class GetMyFavoriteListSuccessfulState extends FavoriteState {}


class GetMyFavoriteListErrorState extends FavoriteState {
  final String message;
  GetMyFavoriteListErrorState({required this.message});
}




class FavoriteToCartSuccessfulState extends FavoriteState {}


class FavoriteToCartErrorState extends FavoriteState {
  final String message;
  FavoriteToCartErrorState({required this.message});
}