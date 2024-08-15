import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class PasswordState extends LoginState {
  final bool isPasswordVisible;

  const PasswordState(this.isPasswordVisible);

  @override
  List<Object> get props => [isPasswordVisible];
}


class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure(this.error);

  @override
  List<Object> get props => [error];
}
