import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterSubmitted extends RegisterEvent {
  final String username;
  final String password;

  const RegisterSubmitted(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class TogglePasswordVisibility extends RegisterEvent {
  final bool password;
  const TogglePasswordVisibility(  this.password);

  @override
  // TODO: implement props
  List<Object> get props => [  password];
}
class UpdateAge extends RegisterEvent {
  final int age;
  const UpdateAge(  this.age);

  @override
  // TODO: implement props
  List<Object> get props => [  age];
}
class UpdateGender extends RegisterEvent {
  final String gender;
  const UpdateGender(  this.gender);

  @override
  // TODO: implement props
  List<Object> get props => [  gender];
}
class SendOtpEvent extends RegisterEvent {
  final String phoneNumber;

  const SendOtpEvent(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}
class SaveUserEvent extends RegisterEvent {
  final String phoneNumber;
  final String name;
  final String age;
  final String password;
  final String gender;

  const SaveUserEvent(this.phoneNumber, this.name, this.age, this.password, this.gender);


  @override
  List<Object> get props => [phoneNumber,name,age,password,gender];
}
class VerifyOtpEvent extends RegisterEvent {
  final String otp;

  const VerifyOtpEvent(this.otp);

  @override
  List<Object> get props => [otp];
}
class ToggleConfirmPasswordVisibility extends RegisterEvent {
  final bool confirmPassword;
  const ToggleConfirmPasswordVisibility(  this.confirmPassword);

  @override
  // TODO: implement props
  List<Object> get props => [  confirmPassword];

}