import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginSubmitted extends LoginEvent {
  final String username;
  final String password;

  const LoginSubmitted(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class TogglePasswordVisibility extends LoginEvent {
  @override
  List<Object> get props => [];
}
