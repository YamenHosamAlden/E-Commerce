part of 'orders_bloc.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

class GetOrderLoadingState extends OrdersState {}

class GetOrderSuccessfulState extends OrdersState {}

class GetOrderErrorState extends OrdersState {
  final String message;
  GetOrderErrorState({required this.message});
}

class GetAllOrdersLoadingState extends OrdersState {}

class GetAllOrdersSuccessfulState extends OrdersState {}

class GetAllOrdersErrorState extends OrdersState {
  final String message;
  GetAllOrdersErrorState({required this.message});
}
