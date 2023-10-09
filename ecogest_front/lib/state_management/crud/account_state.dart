part of 'account_cubit.dart';

class AccountInitial extends InitialState {}

class AccountLoading extends LoadingState {}

class AccountLoaded extends LoadedState<Account> {
  AccountLoaded(Account data) : super(data);
}

class AccountError extends ErrorState {}
