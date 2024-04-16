class UserState {}

final class UserInitial extends UserState {}

final class SingInSuccess extends UserState {}

final class SingInFailed extends UserState {
  final String errorMessage;
  SingInFailed({required this.errorMessage});
}

final class SingInLoading extends UserState {}

