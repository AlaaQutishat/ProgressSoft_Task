import 'package:equatable/equatable.dart';

abstract class OtpState extends Equatable {

  const OtpState( );

  @override
  List<Object> get props => [];
}

class InitialState extends OtpState {

  final String  otp;
  final String  verifyId;


  const InitialState( {this.otp="", this.verifyId="",
  });
  InitialState copyWith({

    String? otp,
    String? verifyId,
  }) {
    return InitialState(

      otp: otp ?? this.otp,
      verifyId: verifyId ?? this.verifyId,
    );
  }
  @override
  List<Object> get props => [verifyId, otp ];
}


class AuthLoading extends OtpState {}



class AuthVerified extends OtpState {}

class AuthError extends OtpState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}


