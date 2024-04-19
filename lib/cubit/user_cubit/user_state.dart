import 'package:happy_tech_mastering_api_with_flutter/models/User_model.dart';

class UserState {}

final class UserInitial extends UserState {}

final class SingInSuccess extends UserState {}

final class SingInFailed extends UserState {
  final String errorMessage;

  SingInFailed({required this.errorMessage});
}

final class SingInLoading extends UserState {}

final class UploadImageSuccess extends UserState {}

final class SingUpSuccess extends UserState {
  final String message;

  SingUpSuccess(this.message);
}

final class SingUpFailed extends UserState {
  final String errorMessage;

  SingUpFailed({required this.errorMessage});
}

final class SingUpLoading extends UserState {}

final class UserSuccess  extends UserState {
  final UserModel user;

  UserSuccess(this.user);
}

final class UserFailed extends UserState {
  final String errorMessage;

  UserFailed({required this.errorMessage});
}

final class UserLoading extends UserState {}
