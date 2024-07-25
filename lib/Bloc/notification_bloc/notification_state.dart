part of 'notification_bloc.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}
class GetNotificationsLoadingState extends NotificationState {}

class GetNotificationsSuccessfulState extends NotificationState {}

class GetNotificationsErrorState extends NotificationState {
  final String message;
  GetNotificationsErrorState({required this.message});
}
