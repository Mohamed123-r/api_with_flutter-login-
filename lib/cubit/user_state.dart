class UserState {}

final class UserInitial extends UserState {}

final class SignInSuccess extends UserState {}

final class SignInFailure extends UserState {
  final String error;

  SignInFailure({required this.error});
}

final class SignInLoading extends UserState {}
