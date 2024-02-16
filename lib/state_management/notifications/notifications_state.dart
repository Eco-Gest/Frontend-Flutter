part of 'notifications_cubit.dart';

abstract class NotificationsState {}

class NotificationsStateInitial extends NotificationsState {}

class NotificationsStateLoading extends NotificationsState {}

class NotificationsStateSuccess extends NotificationsState {
  final List<NotificationModel>? notifications;

  NotificationsStateSuccess(this.notifications);
}

class NotificationsStateError extends NotificationsState {
  final String message;

  NotificationsStateError(this.message);
}