part of 'notification_bloc.dart';

@immutable
sealed class NotificationEvent {}

class GetNotificationsEvent extends NotificationEvent{}

class SetSeenNotificationEvent extends NotificationEvent{
  
}
