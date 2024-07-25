part of 'orders_bloc.dart';

@immutable
sealed class OrdersEvent {}

final class GetAllOrdersEvent extends OrdersEvent {}

final class GetOrderEvent extends OrdersEvent {
  final int orderId;

  GetOrderEvent({required this.orderId});
}
