import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/models/account_model.dart';
import 'package:ecogest_front/services/account_service.dart';
import 'package:ecogest_front/state_management/crud/base_state.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<BaseState> {
  AccountCubit() : super(AccountInitial());

  Future<void> getAccountById({required int id}) async {
    emit(AccountLoading());
    try {
      final account = await AccountService.getUserAccount();
      emit(AccountLoaded(account));
    } catch (e) {
      emit(AccountError());
    }
  }
}
