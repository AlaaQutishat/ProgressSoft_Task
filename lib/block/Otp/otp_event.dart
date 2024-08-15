import 'package:equatable/equatable.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();
}



class UpdateOtp extends OtpEvent {
  final String otp;
  const UpdateOtp(  this.otp);

  @override
  // TODO: implement props
  List<Object> get props => [  otp];
}
class UpdateVerifyId extends OtpEvent {
  final String verifyId;
  const UpdateVerifyId(  this.verifyId);

  @override
  // TODO: implement props
  List<Object> get props => [  verifyId];
}

class VerifyOtpEvent extends OtpEvent {
  final String otp;
  final String verifyId;
  const VerifyOtpEvent(this.otp,this.verifyId);

  @override
  List<Object> get props => [otp,verifyId];
}
