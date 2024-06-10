import 'package:ecogest_front/services/users_relation_service.dart';
import 'package:ecogest_front/state_management/users_relation/users_relation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersRelationCubit extends Cubit<UsersRelationState> {
  UsersRelationCubit() : super(UsersRelationStateInitial());

  Future<void> subscription(int userId, bool isFollowing) async {
    try {
      if (isFollowing) {
        await UsersRelationService.cancel(userId);
        emit(SubscriptionCancelStateSuccess());
      } else {
        await UsersRelationService.subscribe(userId);
        emit(SubscriptionStateSuccess());
      }
    } catch (error) {
      emit(UsersRelationStateError("Erreur rencontrée. Veuillez réessayer."));
    }
  }

  Future<void> unSubscribe(int userId) async {
    try {
      emit(UsersRelationStateLoading());
      await UsersRelationService.unSubscribe(userId);
      emit(UnSubscriptionStateSuccess(userId));
    } catch (error) {
      emit(UsersRelationStateError("Erreur rencontrée. Veuillez réessayer."));
    }
  }

  Future<void> approveOrDeclineSubscription(
      int userId, String approveOrDecline) async {
    try {
      emit(UsersRelationStateLoading());
      if (approveOrDecline == "Accepter") {
        await UsersRelationService.approve(userId);
      } else {
        await UsersRelationService.decline(userId);
      }
      emit(SubscriptionApproveOrDeclineStateSuccess());
    } catch (error) {
      emit(UsersRelationStateError("Erreur rencontrée. Veuillez réessayer."));
    }
  }

  Future<void> removeFollower(int userId) async {
    try {
      emit(UsersRelationStateLoading());
      await UsersRelationService.removeFollower(userId);
      emit(RemoveFollowerStateSuccess(userId));
    } catch (error) {
      emit(UsersRelationStateError("Erreur rencontrée. Veuillez réessayer."));
    }
  }

    Future<void> blockUser(int userId) async {
    try {
      emit(UsersRelationStateLoading());
      await UsersRelationService.blockUser(userId);
      emit(BlockStateSuccess());
    } catch (error) {
      emit(UsersRelationStateError("Erreur rencontrée. Veuillez réessayer."));
    }
  }

    Future<void> unblockUser(int userId) async {
    try {
      emit(UsersRelationStateLoading());
      await UsersRelationService.unBlockUser(userId);
      emit(UnBlockStateSuccess());
    } catch (error) {
      emit(UsersRelationStateError("Erreur rencontrée. Veuillez réessayer."));
    }
  }
}
