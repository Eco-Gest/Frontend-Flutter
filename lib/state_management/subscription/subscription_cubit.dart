import 'package:ecogest_front/services/subscription_service.dart';
import 'package:ecogest_front/state_management/subscription/subscription_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit() : super(SubscriptionStateInitial());

  Future<void> subscription(int userId, bool isFollowing) async {
    try {
      if (isFollowing) {
        await SubscriptionService.cancel(userId);
        emit(SubscriptionCancelStateSuccess());
      } else {
        await SubscriptionService.subscribe(userId);
        emit(SubscriptionStateSuccess());
      }
    } catch (error) {
      emit(SubscriptionStateError("Erreur rencontrée. Veuillez réessayer."));
    }
  }

  Future<void> unSubscribe(int userId) async {
    try {
      emit(SubscriptionStateLoading());
      await SubscriptionService.unSubscribe(userId);
      emit(UnSubscriptionStateSuccess());
    } catch (error) {
      emit(SubscriptionStateError("Erreur rencontrée. Veuillez réessayer."));
    }
  }

  Future<void> approveOrDeclineSubscription(
      int userId, String approveOrDecline) async {
    try {
      emit(SubscriptionStateLoading());
      if (approveOrDecline == "Accepter") {
        await SubscriptionService.approve(userId);
      } else {
        await SubscriptionService.decline(userId);
      }
      emit(SubscriptionApproveOrDeclineStateSuccess());
    } catch (error) {
      emit(SubscriptionStateError("Erreur rencontrée. Veuillez réessayer."));
    }
  }

  Future<void> removeFollower(int userId) async {
    try {
      emit(SubscriptionStateLoading());
      await SubscriptionService.removeFollower(userId);
      emit(RemoveFollowerStateSuccess());
    } catch (error) {
      emit(SubscriptionStateError("Erreur rencontrée. Veuillez réessayer."));
    }
  }
}
