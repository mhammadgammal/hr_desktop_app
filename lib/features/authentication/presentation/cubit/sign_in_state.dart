part of 'sign_in_cubit.dart';

@immutable
sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class SignInLoadingState extends SignInState {}

final class SignInSuccessState extends SignInState {}

final class RememberMeStatusChangedState extends SignInState {
  final bool rememberMe;

  RememberMeStatusChangedState(this.rememberMe);
}

final class SignInFailureState extends SignInState {
  late final String message;

  SignInFailureState(this.message);
}
