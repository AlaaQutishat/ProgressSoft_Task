import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final String gender;
  final int age;
  const RegisterState({
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.gender = "Male",
    this.age = 18,
  });
  @override
  List<Object> get props => [isPasswordVisible, isConfirmPasswordVisible, gender, age];
}

class InitialState extends RegisterState {
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final String  gender;
  final int age;
  const InitialState( {this.gender="Male", this.age=18,
      this.isPasswordVisible =false,
      this.isConfirmPasswordVisible=false,
  });
  InitialState copyWith({
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    String? gender,
    int? age,
  }) {
    return InitialState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      gender: gender ?? this.gender,
      age: age ?? this.age,
    );
  }
  @override
  List<Object> get props => [isPasswordVisible, isConfirmPasswordVisible ,gender,age];
}

class GenderSelected extends RegisterState {
  final String gender;
  const GenderSelected(this.gender);
}

class AgeSelected extends RegisterState {
  final int age;
  const AgeSelected(this.age);
}
class AuthLoading extends RegisterState {}

class AuthOtpSent extends RegisterState {
  final String verificationId;
  const AuthOtpSent(this.verificationId);
  @override
  List<Object> get props => [verificationId];
}

class AuthVerified extends RegisterState {}

class AuthError extends RegisterState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}


class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}


class RegisterFailure extends RegisterState {
  final String error;

  const RegisterFailure(this.error);

  @override
  List<Object> get props => [error];
}
