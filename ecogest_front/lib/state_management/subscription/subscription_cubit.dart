import 'package:ecogest_front/services/subscription_service.dart';
import 'package:ecogest_front/state_management/subscription/subscription_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit() : super(SubscriptionStateInitial());

  Future<void> subscription(int userId, String state) async {
    try {
      if (state == "subscribe") {
        await SubscriptionService.subscribe(userId);
      } else if (state == "cancel") {
        await SubscriptionService.cancel(userId);
      }
      emit(SubscriptionStateSuccess());
    } catch (error) {
      emit(SubscriptionStateError(error.toString()));
    }
  }

  Future<void> unSubscribe(int userId) async {
    try {
      emit(SubscriptionStateLoading());
      await SubscriptionService.unSubscribe(userId);
      emit(SubscriptionStateSuccess());
    } catch (error) {
      emit(SubscriptionStateError(error.toString()));
    }
  }

  Future<void> approveOrDeclineSubscription(int userId, String approveOrDecline) async {
    try {
      emit(SubscriptionStateLoading());
      if (approveOrDecline == "Accepter") {
        await SubscriptionService.approve(userId);
      } else {
        await SubscriptionService.cancel(userId);
      }
      emit(SubscriptionStateSuccess());
    } catch (error) {
      emit(SubscriptionStateError(error.toString()));
    }
  }
}
