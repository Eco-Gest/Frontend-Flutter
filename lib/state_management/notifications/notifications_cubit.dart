import 'package:ecogest_front/models/notification_model.dart';
import 'package:ecogest_front/services/notifications/notifications_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsStateInitial());

  Future<void> getNotifications() async {
    try {
      emit(NotificationsStateLoading());
      final notifications = await NotificationsService.getNotifications();
      emit(NotificationsStateSuccess(notifications));
    } catch (error) {
      emit(NotificationsStateError(
          "Erreur lors de la récupération de vos notifications"));
    }
  }
}
